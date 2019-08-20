Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3619B95770
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 08:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbfHTGnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 02:43:19 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52522 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfHTGnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 02:43:19 -0400
Received: by mail-wm1-f65.google.com with SMTP id o4so1566912wmh.2;
        Mon, 19 Aug 2019 23:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0XAzeGSJHGOFWxURHAOeVeqy4oMuwXyuhlisAQdgna0=;
        b=HZXaNsEL8FCCPpoPnqPTf47Mly0iJP3FPoxn1xkOIV0e+NDUZZzSP6md8ZoMl3t7XF
         iDya0/hf8f6Dbe1S75noAW0jeq1omgFaD23GJ9sSotnQu1C5Jki6ZOvoY6qEcTh0p5G9
         KBGjgcpcIjE/YeklbegBZpp8+c7WoXIiwDmHzNiIDkvN57ZQkRbGeVLSpXsSYnn60ekH
         v7gpqjNk2zH9CPCfnhN5qqtzH45rT1W3btLlMqJBR48ouSajV4Y68sbSh6hym1HbjwK2
         1mpOb+wMfwKvYSsAP5sa8UiywXEU1WDg6xzsqg4HDDZe6VnrCryrJVpGGzvKNsjbhtyP
         1utg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0XAzeGSJHGOFWxURHAOeVeqy4oMuwXyuhlisAQdgna0=;
        b=WnlWuipd1HaafnAkDwzYzBR8Xda479tyOUe/AUZ/pL3mz38rftYoId6JX8HAGgUrR5
         ACo4ULSWn3Q35MHX85wKT07+sNraDHKkhBCnVMnDE/PaSxX+LxMj2eUKFqdGMZD75otJ
         dBirnbaxJzlOgNJnjZ7rjPV2fW/byD49TRw83EmsO4T73LGpDjkQdIrxX0I+1Z6zhbsz
         f7wDu7aNENolOruGuq4jxij2O75nvnTLtVUjJ7n51Z3f/i0TbE3ERZAOWlcvpFaU0D/u
         CkDNXVbtMABYFSseHKUA12trwgz1wh4PZ5XmPzplA1X8+JK3JVEtHWcL/QUMfFNg9DO/
         hDdQ==
X-Gm-Message-State: APjAAAUABXeS+qU78DmKM2gWYPmKvxbIT3TuuDeamCrALj6ZmPb1asjB
        EHwNVCXsJ8rnppBoTF1JVDg=
X-Google-Smtp-Source: APXvYqx9jTVPh7Q3QPN80Pj0XZW1XRowf0FTlGCKaCIZGil7Xt976TZ4+5X7yd1NLmm5g7rpOQmHTA==
X-Received: by 2002:a05:600c:2192:: with SMTP id e18mr1970515wme.83.1566283397357;
        Mon, 19 Aug 2019 23:43:17 -0700 (PDT)
Received: from localhost.localdomain ([151.29.237.107])
        by smtp.gmail.com with ESMTPSA id c15sm48432264wrb.80.2019.08.19.23.43.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Aug 2019 23:43:16 -0700 (PDT)
Date:   Tue, 20 Aug 2019 08:43:14 +0200
From:   Juri Lelli <juri.lelli@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>, tglx@linutronix.de,
        bigeasy@linutronix.de, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, williams@redhat.com
Subject: Re: [RT PATCH v2] net/xfrm/xfrm_ipcomp: Protect scratch buffer with
 local_lock
Message-ID: <20190820064314.GC6860@localhost.localdomain>
References: <20190819122731.6600-1-juri.lelli@redhat.com>
 <20190819155721.05c878f8@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819155721.05c878f8@oasis.local.home>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/08/19 15:57, Steven Rostedt wrote:
> On Mon, 19 Aug 2019 14:27:31 +0200
> Juri Lelli <juri.lelli@redhat.com> wrote:
> 
> > The following BUG has been reported while running ipsec tests.
> 
> Thanks!
> 
> I'm still in the process of backporting patches to fix some bugs that
> showed up with the latest merge of upstream stable. I'll add this to
> the queue to add.

Great, thank you!

Best,

Juri
