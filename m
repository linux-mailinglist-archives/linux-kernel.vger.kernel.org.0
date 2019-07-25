Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2BB75B42
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 01:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfGYXbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 19:31:16 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57292 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfGYXbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 19:31:15 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hqnCa-00044o-51; Thu, 25 Jul 2019 23:31:12 +0000
Date:   Fri, 26 Jul 2019 00:31:12 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: linux-next: run time BUG after merge of the vfs-fixes tree?
Message-ID: <20190725233112.GI1131@ZenIV.linux.org.uk>
References: <20190725144712.39cb1e5b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725144712.39cb1e5b@canb.auug.org.au>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 02:47:12PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> During my qemu boot tests (powerpc64 pseries_le_defconfig) today, I got
> the following BUG:

... caused by mismerge.  #fixes does
@@ -1471,10 +1470,11 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
                                list_add_tail(&p->mnt_child, &p->mnt_parent->mnt_mounts);
                        } else {
                                umount_mnt(p);
-                               hlist_add_head(&p->mnt_umount, &unmounted);
                        }
                }
                change_mnt_propagation(p, MS_PRIVATE);
+               if (disconnect)
+                       hlist_add_head(&p->mnt_umount, &unmounted);
        }
 }
and your merge has dropped the removal part - it has
                                list_add_tail(&p->mnt_child, &p->mnt_parent->mnt_mounts);
                        } else {
                                umount_mnt(p);
                                hlist_add_head(&p->mnt_umount, &unmounted);
                        }
                }
                change_mnt_propagation(p, MS_PRIVATE);
                if (disconnect)
                        hlist_add_head(&p->mnt_umount, &unmounted);
        }
}

Should've #work.dcache from there once (equal) #work.dcache2 got pulled ;-/
