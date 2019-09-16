Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA84B3950
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 13:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731108AbfIPL2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 07:28:11 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42467 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfIPL2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 07:28:11 -0400
Received: by mail-wr1-f67.google.com with SMTP id q14so38430566wrm.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 04:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=i0QAHtwg2bJr9TRIhFHWNl1h8xcMijKU46PcWoDwc+E=;
        b=W7iwbaPCxY69/4BiXe2ilZ7wASkc9ldokBbx1LH6RuiHLCTq/QlwsDBXNdFsndAg8t
         52qp13VXTksTZGvQcgZq8b86WatOn6oXKNlyszxAvhD4uECCiy6p6oMWoSXVihxqycr7
         KBqwRsGIWwDMcvvDmfMIJvQsdT7M7HRKON/YD9t0R1fXlrXyd6wkwxZyK7VNeY2ZVgeS
         XseZwNRaH3i48/pjjlv4J/CRlSLRfyU6jnRxXapnfPXzLLEJ/Y9l2RCzEdlKLDGFgJch
         qejtxbhKVAzYDIvAsS9g4PGm9ZF+oADajkRUY2cy5jsgtxab9kdrOYIupopt61WbFd9J
         s2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=i0QAHtwg2bJr9TRIhFHWNl1h8xcMijKU46PcWoDwc+E=;
        b=kHo1MBWgLXocKOzWdx+3o/9/ZBlHm6eh9E8EaE1X0iv4XTibK5nL5ESC07i0cFcI+1
         rsG0QnVdbQlYBs3810EqVavD3lZIkzvqGIABRKYGDz32U16ou4jSjNTvExfpn2MYVFVj
         TCyYixwshHhlkNPRrOdtA2D4yXb+AjUJN5K3ixvty0KOsb1FBVetxida6sFOVLAd8j0x
         35jQZ2QCD7hIoUiXSV9pu72rNlCp+n2GGuonOivWEbz+RLflRnMCFFDqdmxuD77oJ9XM
         uNUcRoAlP1eL7MwnDB/X+BGXVUjY3GZ9x2UxFiV1XsvwHhWj8+obO6H5dTzl6XDYOwYj
         8Lvg==
X-Gm-Message-State: APjAAAUMdt6nFRBtUXOQbC1WYWkyQIVKTY3uxIDSGu1htZnLoHXzekT1
        U4xIPCxFEIHtPdQps9xOmbI=
X-Google-Smtp-Source: APXvYqwuhZqsAScVxFcyhaW+NitxKaGAOLE+QSTdF+bEsrphCewj4Z0mbcsyZ32+TDNoGoJ6zM/A9w==
X-Received: by 2002:a5d:6043:: with SMTP id j3mr9356337wrt.337.1568633288833;
        Mon, 16 Sep 2019 04:28:08 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id c6sm10834950wrm.71.2019.09.16.04.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 04:28:08 -0700 (PDT)
Date:   Mon, 16 Sep 2019 13:28:06 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] core/stacktrace change for v5.4
Message-ID: <20190916112806.GA40858@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest core-stacktrace-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-stacktrace-for-linus

   # HEAD: ee050dc83bc326ad5ef8ee93bca344819371e7a5 lib/stackdepot: Fix outdated comments

Two comment fixes.

 Thanks,

	Ingo

------------------>
Miles Chen (1):
      lib/stackdepot: Fix outdated comments


 lib/stackdepot.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 66cab785bea0..ed717dd08ff3 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -87,7 +87,7 @@ static bool init_stack_slab(void **prealloc)
 		stack_slabs[depot_index + 1] = *prealloc;
 		/*
 		 * This smp_store_release pairs with smp_load_acquire() from
-		 * |next_slab_inited| above and in depot_save_stack().
+		 * |next_slab_inited| above and in stack_depot_save().
 		 */
 		smp_store_release(&next_slab_inited, 1);
 	}
@@ -114,7 +114,7 @@ static struct stack_record *depot_alloc_stack(unsigned long *entries, int size,
 		depot_offset = 0;
 		/*
 		 * smp_store_release() here pairs with smp_load_acquire() from
-		 * |next_slab_inited| in depot_save_stack() and
+		 * |next_slab_inited| in stack_depot_save() and
 		 * init_stack_slab().
 		 */
 		if (depot_index + 1 < STACK_ALLOC_MAX_SLABS)
