Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13345B9FE4
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2019 00:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfIUWiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Sep 2019 18:38:51 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:32848 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfIUWiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 18:38:51 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iBo1f-0006TZ-OP; Sat, 21 Sep 2019 22:38:47 +0000
Date:   Sat, 21 Sep 2019 23:38:47 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Pavel Shilovsky <piastryyy@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steve French <stfrench@microsoft.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        linux-cifs <linux-cifs@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: build_path_from_dentry_optional_prefix() may schedule from
 invalid context
Message-ID: <20190921223847.GB29065@ZenIV.linux.org.uk>
References: <20190829050237.GA5161@jagdpanzerIV>
 <CAKywueRd4d_fojGL+n4BisoibhgkYfN9Wyc_+0=-1sarz4-HZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKywueRd4d_fojGL+n4BisoibhgkYfN9Wyc_+0=-1sarz4-HZw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 05:11:54PM -0700, Pavel Shilovsky wrote:

> Good catch. I think we should have another version of
> build_path_from_dentry() which takes pre-allocated (probably on stack)
> full_path as an argument. This would allow us to avoid allocations
> under the spin lock.

On _stack_?  For relative pathname?  Er...  You do realize that
kernel stack is small, right?  And said relative pathname can
bloody well be up to 4Kb (i.e. the half of said stack already,
on top of whatever the call chain has already eaten up)...

BTW, looking at build_path_from_dentry()...  WTF is this?
                temp = temp->d_parent;
                if (temp == NULL) {
                        cifs_dbg(VFS, "corrupt dentry\n");
                        rcu_read_unlock();
                        return NULL;
                }
Why not check for any number of other forms of memory corruption?
Like, say it, if (temp == (void *)0xf0adf0adf0adf0ad)?

IOW, kindly lose that nonsense.  More importantly, why bother
with that kmalloc()?  Just __getname() in the very beginning
and __putname() on failure (and for freeing the result afterwards).

What's more, you are open-coding dentry_path_raw(), badly.
The only differences are
	* use of dirsep instead of '/' and
	* a prefix slapped in the beginning.

I'm fairly sure that
	char *buf = __getname();
	char *s;

	*to_free = NULL;
	if (unlikely(!buf))
		return NULL;

	s = dentry_path_raw(dentry, buf, PATH_MAX);
	if (IS_ERR(s) || s < buf + prefix_len)
		__putname(buf);
		return NULL; // assuming that you don't care about details
	}

	if (dirsep != '/') {
		char *p = s;
		while ((p = strchr(p, '/')) != NULL)
			*p++ = dirsep;
	}

	s -= prefix_len;
	memcpy(s, prefix, prefix_len);
	
	*to_free = buf;
	return s;

would end up being faster, not to mention much easier to understand.
With the caller expected to pass &to_free among the arguments and
__putname() it once it's done.

Or just do __getname() in the caller and pass it to the function -
in that case freeing (in all cases) would be up to the caller.
