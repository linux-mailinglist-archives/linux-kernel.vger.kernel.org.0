Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F326716B757
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 02:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbgBYBsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 20:48:54 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41018 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbgBYBsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 20:48:54 -0500
Received: by mail-qt1-f195.google.com with SMTP id l21so7994747qtr.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 17:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lQ7GCo7cVwQFlLI9a2rMkRqHCZRbg3JBq4Afyow0Kjw=;
        b=u9eyt5e7DOImqpnhRcwRosrVhrBa0EeN4ldTCttmJAwxh8och5yVQBD/Z1NimveKBy
         JCehb1Mlczdo3yY7lezHYj6Vb/0YBlLVrwd0pP8BndXyMnDn+fLGxtXBlh0GiuGmLR5L
         EI+Dakp7T+mYiWK/qrV58aATfyGciKuEl8DEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lQ7GCo7cVwQFlLI9a2rMkRqHCZRbg3JBq4Afyow0Kjw=;
        b=EQz+gEjaGJChBXb+8AyHFscx+bl7pAy+PdmRLmHbd/Ouhu0ropmKEMdEwYygjk8kl/
         yBQq80QDDe9zlAFg3wFPciZILgCi1ZXEaT9iGPo+JGcovB4wt2sWu53ggkjUHrMc4/kn
         QIlMOlVuNSiQ1xwKcHTiax/B+65rFLrHRJUhCzHuAhsyuMfxZ7TYLGbzwJje8ZKwGUMT
         pitZdq1DdxKaQpErWnUkGPn4Tu3OkoxneWUpes7morIkj2YGrH5a4OakrtbXg6yfOlyv
         hxiMTK3p77CV6R5y+ZSsmY5GI/XWobhILb+bWv4F6UzsUUuuKyLsjLzapNbknrYLm0ip
         40RQ==
X-Gm-Message-State: APjAAAWhiZFU8GzzzkZqWrUan/URDf4ydGB5LUHUfybzhus0GpTpBfQW
        TOUE4lLl6sMez/q5Fdgl1KYnsg==
X-Google-Smtp-Source: APXvYqyp8ViMH6odn4BmLMO9B5r+MxrJYojbCDAawTdrvd0x0I/XETGNP1jpPH6KxNDMYhjH7G1UkQ==
X-Received: by 2002:ac8:4542:: with SMTP id z2mr49739414qtn.324.1582595333320;
        Mon, 24 Feb 2020 17:48:53 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id f128sm4286143qke.54.2020.02.24.17.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 17:48:52 -0800 (PST)
Date:   Mon, 24 Feb 2020 20:48:51 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Suraj Jitindar Singh <surajjs@amazon.com>,
        LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org
Subject: Re: [PATCH RFC] ext4: fix potential race between online resizing and
 write operations
Message-ID: <20200225014851.GA237890@google.com>
References: <20200215233817.GA670792@mit.edu>
 <20200216121246.GG2935@paulmck-ThinkPad-P72>
 <20200217160827.GA5685@pc636>
 <20200217193314.GA12604@mit.edu>
 <20200218170857.GA28774@pc636>
 <20200221120618.GA194360@google.com>
 <20200221132817.GB194360@google.com>
 <20200221192152.GA6306@pc636>
 <20200222221253.GB191380@google.com>
 <20200224170219.GA21229@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224170219.GA21229@pc636>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[..]
> > > > debug_objects bits wouldn't work obviously for the !emergency kvfree case,
> > > > not sure what we can do there.
> > > >
> > > Agree.
> > > 
> > > Thank you, Joel, for your comments!
> > 
> > No problem, I think we have a couple of ideas here.
> > 
> > What I also wanted to do was (may be after all this), see if we can create an
> > API for head-less kfree based on the same ideas. Not just for arrays for for
> > any object. Calling it, say, kfree_rcu_headless() and then use the bulk array
> > as we have been doing. That would save any users from having an rcu_head --
> > of course with all needed warnings about memory allocation failure. Vlad,
> > What do you think? Paul, any thoughts on this?
> > 
> I like it. It would be more clean interface. Also there are places where
> people do not embed the rcu_head into their stuctures for some reason
> and do like:
> 
> 
> <snip>
>     synchronize_rcu();
>     kfree(p);
> <snip>
> 
> <snip>
> urezki@pc636:~/data/ssd/coding/linux-rcu$ find ./ -name "*.c" | xargs grep -C 1 -rn "synchronize_rcu" | grep kfree
> ./arch/x86/mm/mmio-mod.c-314-           kfree(found_trace);
> ./kernel/module.c-3910- kfree(mod->args);
> ./kernel/trace/ftrace.c-5078-                   kfree(direct);
> ./kernel/trace/ftrace.c-5155-                   kfree(direct);
> ./kernel/trace/trace_probe.c-1087-      kfree(link);
> ./fs/nfs/sysfs.c-113-           kfree(old);
> ./fs/ext4/super.c-1701- kfree(old_qname);
> ./net/ipv4/gre.mod.c-36-        { 0xfc3fcca2, "kfree_skb" },
> ./net/core/sysctl_net_core.c-143-                               kfree(cur);
> ./drivers/crypto/nx/nx-842-pseries.c-1010-      kfree(old_devdata);
> ./drivers/misc/vmw_vmci/vmci_context.c-692-             kfree(notifier);
> ./drivers/misc/vmw_vmci/vmci_event.c-213-       kfree(s);
> ./drivers/infiniband/core/device.c:2162:                         * synchronize_rcu before the netdev is kfreed, so we
> ./drivers/infiniband/hw/hfi1/sdma.c-1337-       kfree(dd->per_sdma);
> ./drivers/net/ethernet/myricom/myri10ge/myri10ge.c-3582-        kfree(mgp->ss);
> ./drivers/net/ethernet/myricom/myri10ge/myri10ge.mod.c-156-     { 0x37a0cba, "kfree" },
> ./drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c:286:       synchronize_rcu(); /* before kfree(flow) */
> ./drivers/net/ethernet/mellanox/mlxsw/core.c-1504-      kfree(rxl_item);
> ./drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c-6648- kfree(adapter->mbox_log);
> ./drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c-6650- kfree(adapter);
> ./drivers/block/drbd/drbd_receiver.c-3804-      kfree(old_net_conf);
> ./drivers/block/drbd/drbd_receiver.c-4176-                      kfree(old_disk_conf);
> ./drivers/block/drbd/drbd_state.c-2074-         kfree(old_conf);
> ./drivers/block/drbd/drbd_nl.c-1689-    kfree(old_disk_conf);
> ./drivers/block/drbd/drbd_nl.c-2522-    kfree(old_net_conf);
> ./drivers/block/drbd/drbd_nl.c-2935-            kfree(old_disk_conf);
> ./drivers/mfd/dln2.c-178-               kfree(i);
> ./drivers/staging/fwserial/fwserial.c-2122-     kfree(peer);
> <snip>

Wow that's pretty amazing, looks like could be very useful.

Do you want to continue your patch and then post it, and we can discuss it?
Or happy to take it as well.

We could split work into 3 parts:
1. Make changes for 2 separate per-CPU arrays. One for vfree and one for kfree.
2. Add headless support for both as alternative API.
3. Handle the low memory case somehow (I'll reply to the other thread).

May be we can start with 1. where you can clean up your patch and post, and
then I/we can work based on that?

thanks,

 - Joel

