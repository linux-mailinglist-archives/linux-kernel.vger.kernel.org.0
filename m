Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E31BC11FC9B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 02:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfLPBgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Dec 2019 20:36:51 -0500
Received: from vps.xff.cz ([195.181.215.36]:33092 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbfLPBgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 20:36:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1576460208; bh=Dc+4VY0fwInaV8UcaS6wuEmwDmotUHSvsIUdzuev2vM=;
        h=Date:From:To:Subject:References:X-My-GPG-KeyId:From;
        b=Ui2MvfubnERriw/czaJv1TZlzx63QIYko+WCvn3IF/kwW8zivSHt94zrMUnSQVH8X
         8ComZqU6KqIq0ISXKiB4gvkEPyIJhlt8INBGaciAshL5mVOJ+svzKSuuk4zUK23IGe
         /1BQkQNmHQLHu1BOC4J4nsr4XhkKNq2iaxb+/RBA=
Date:   Mon, 16 Dec 2019 02:36:48 +0100
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] init: use do_mount() instead of ksys_mount()
Message-ID: <20191216013648.4byckmwtehftwo42@core.my.home>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
References: <20191212135724.331342-1-linux@dominikbrodowski.net>
 <20191212135724.331342-4-linux@dominikbrodowski.net>
 <20191216013536.5wyvq4vjv5efd35n@core.my.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216013536.5wyvq4vjv5efd35n@core.my.home>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 02:35:36AM +0100, megi xff wrote:
> Hello,
> 
> On Thu, Dec 12, 2019 at 02:57:24PM +0100, Dominik Brodowski wrote:
> > In prepare_namespace(), do_mount() can be used instead of ksys_mount()
> > as the first and third argument are const strings in the kernel, the
> > second and fourth argument are passed through anyway, and the fifth
> > argument is NULL.
> > 
> > In do_mount_root(), ksys_mount() is called with the first and third
> > argument being already kernelspace strings, which do not need to be
> > copied over from userspace to kernelspace (again). The second and
> > fourth arguments are passed through to do_mount() anyway. The fifth
> > argument, while already residing in kernelspace, needs to be put into
> > a page of its own. Then, do_mount() can be used instead of
> > ksys_mount().
> > 
> > Once this is done, there are no in-kernel users to ksys_mount() left,
> > which can therefore be removed.
> > 
> > Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
> > ---
> >  fs/namespace.c           | 10 ++--------
> >  include/linux/syscalls.h |  2 --
> >  init/do_mounts.c         | 28 ++++++++++++++++++++++------
> >  3 files changed, 24 insertions(+), 16 deletions(-)
> > 
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index 2fd0c8bcb8c1..be601d3a8008 100644
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -3325,8 +3325,8 @@ struct dentry *mount_subtree(struct vfsmount *m, const char *name)
> >  }
> >  EXPORT_SYMBOL(mount_subtree);
> >  
> > -int ksys_mount(const char __user *dev_name, const char __user *dir_name,
> > -	       const char __user *type, unsigned long flags, void __user *data)
> > +SYSCALL_DEFINE5(mount, char __user *, dev_name, char __user *, dir_name,
> > +		char __user *, type, unsigned long, flags, void __user *, data)
> >  {
> >  	int ret;
> >  	char *kernel_type;
> > @@ -3359,12 +3359,6 @@ int ksys_mount(const char __user *dev_name, const char __user *dir_name,
> >  	return ret;
> >  }
> >  
> > -SYSCALL_DEFINE5(mount, char __user *, dev_name, char __user *, dir_name,
> > -		char __user *, type, unsigned long, flags, void __user *, data)
> > -{
> > -	return ksys_mount(dev_name, dir_name, type, flags, data);
> > -}
> > -
> >  /*
> >   * Create a kernel mount representation for a new, prepared superblock
> >   * (specified by fs_fd) and attach to an open_tree-like file descriptor.
> > diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> > index d0391cc2dae9..5262b7a76d39 100644
> > --- a/include/linux/syscalls.h
> > +++ b/include/linux/syscalls.h
> > @@ -1231,8 +1231,6 @@ asmlinkage long sys_ni_syscall(void);
> >   * the ksys_xyzyyz() functions prototyped below.
> >   */
> >  
> > -int ksys_mount(const char __user *dev_name, const char __user *dir_name,
> > -	       const char __user *type, unsigned long flags, void __user *data);
> >  int ksys_umount(char __user *name, int flags);
> >  int ksys_dup(unsigned int fildes);
> >  int ksys_chroot(const char __user *filename);
> > diff --git a/init/do_mounts.c b/init/do_mounts.c
> > index 43f6d098c880..f55cbd9cb818 100644
> > --- a/init/do_mounts.c
> > +++ b/init/do_mounts.c
> > @@ -387,12 +387,25 @@ static void __init get_fs_names(char *page)
> >  	*s = '\0';
> >  }
> >  
> > -static int __init do_mount_root(char *name, char *fs, int flags, void *data)
> > +static int __init do_mount_root(const char *name, const char *fs,
> > +				 const int flags, const void *data)
> >  {
> >  	struct super_block *s;
> > -	int err = ksys_mount(name, "/root", fs, flags, data);
> > -	if (err)
> > -		return err;
> > +	char *data_page;
> > +	struct page *p;
> > +	int ret;
> > +
> > +	/* do_mount() requires a full page as fifth argument */
> > +	p = alloc_page(GFP_KERNEL);
> > +	if (!p)
> > +		return -ENOMEM;
> > +
> > +	data_page = page_address(p);
> > +	strncpy(data_page, data, PAGE_SIZE - 1);
> 
> I tried 5.2-rc2 and I get kernel OOPS/panic here (do_mount_root gets inlined
> into mount_block_root):

5.5-rc2 of course. :)

> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> Mem abort info:
>   ESR = 0x96000005
>   EC = 0x25: DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
> Data abort info:
>   ISV = 0, ISS = 0x00000005
>   CM = 0, WnR = 0
> [0000000000000000] user address but active_mm is swapper
> Internal error: Oops: 96000005 [#1] SMP
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.5.0-rc2-00128-ge93c94cc04ae #5
> Hardware name: OrangePi 3 (DT)
> pstate: 80000005 (Nzcv daif -PAN -UAO)
> pc : strncpy+0x10/0x30
> lr : do_mount_root+0x70/0x114
> sp : ffffffc01002bd20
> x29: ffffffc01002bd20 x28: 0000000000000000
> x27: 0000000000000000 x26: ffffffc011400468
> x25: ffffffc0110d23a0 x24: ffffffff01c396c0
> x23: 0000000000008000 x22: ffffff8078e5b000
> x21: ffffffc0110d23a0 x20: ffffffc0110d2220
> x19: ffffffff01c39700 x18: 00000000fffffffe
> x17: 00000000dbaba8be x16: 0000000000000000
> x15: ffffffffffffffff x14: ffffff0000000000
> x13: ffffff807b490000 x12: 0000000000000000
> x11: 0000000000000000 x10: ffffff807bb96120
> x9 : 0000000000000000 x8 : 0000000000000000
> x7 : ffffffc06a6e6000 x6 : 0000000000000000
> x5 : 000000000003b820 x4 : ffffff8078e5cfff
> x3 : 0000000000000201 x2 : ffffff8078e5c000
> x1 : 0000000000000000 x0 : ffffff8078e5c000
> Call trace:
>  strncpy+0x10/0x30
>  mount_block_root+0x100/0x224
>  mount_root+0x10c/0x124
>  prepare_namespace+0x12c/0x168
>  kernel_init_freeable+0x214/0x258
>  kernel_init+0x10/0xfc
>  ret_from_fork+0x10/0x1c
> Code: b4000142 8b020004 aa0003e2 d503201f (39400023)
> ---[ end trace b72d58d1ea940426 ]---
> Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> SMP: stopping secondary CPUs
> Kernel Offset: disabled
> CPU features: 0x00002,20002000
> Memory Limit: none
> Rebooting in 3 seconds..
> 
> regards,
> 	o.
> 
> > +	ret = do_mount(name, "/root", fs, flags, data_page);
> > +	if (ret)
> > +		goto out;
> >  
> >  	ksys_chdir("/root");
> >  	s = current->fs->pwd.dentry->d_sb;
> > @@ -402,7 +415,10 @@ static int __init do_mount_root(char *name, char *fs, int flags, void *data)
> >  	       s->s_type->name,
> >  	       sb_rdonly(s) ? " readonly" : "",
> >  	       MAJOR(ROOT_DEV), MINOR(ROOT_DEV));
> > -	return 0;
> > +
> > +out:
> > +	put_page(p);
> > +	return ret;
> >  }
> >  
> >  void __init mount_block_root(char *name, int flags)
> > @@ -671,7 +687,7 @@ void __init prepare_namespace(void)
> >  	mount_root();
> >  out:
> >  	devtmpfs_mount();
> > -	ksys_mount(".", "/", NULL, MS_MOVE, NULL);
> > +	do_mount(".", "/", NULL, MS_MOVE, NULL);
> >  	ksys_chroot(".");
> >  }
> >  
> > -- 
> > 2.24.1
> > 
