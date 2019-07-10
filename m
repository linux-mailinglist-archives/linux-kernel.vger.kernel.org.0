Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53C1A647D0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 16:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfGJOMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 10:12:05 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40119 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbfGJOMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 10:12:05 -0400
Received: by mail-qt1-f196.google.com with SMTP id a15so2533866qtn.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 07:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+fGZCi8l8k2+XYBzGCpVW2KcBvE0y5ReGvNijsYR1so=;
        b=CvycXqBbWFtAQGAyh0N9qj4kPJaC+fM3G84OJ+JuynfIwKAPZMeYCQUZOFomOfrCJd
         A2MECOaFl5xTmdG+RljX9d84uzHrfZ57lhAplvskafylhAaBhH5uy2S+7SG9ltB+Gr2f
         q2CxXJ3ET0ee8ZvK5QFcucgYOTEq41gULlkfC9/3J1yLv5TbkNahMBRYzfqL8zlhVfox
         84871x5kZ03YnJzZ2t1/KSYK2pZz+LhlLYCu7ydrup7wivoZ383x+T0NPx/BajSdMju3
         /BlBXGr0WbjCDDmNU8AOc03ufdrIJYWoSPWo2f52MOvLaQzCvjFPN2xrC9lRn8gjpqsA
         hQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=+fGZCi8l8k2+XYBzGCpVW2KcBvE0y5ReGvNijsYR1so=;
        b=VC2UUgZbklEjMwefeGylfFan/6a4e1+oeTrwyZMcpnAgiPhaACRKLAg6XLwRK3CvmH
         T5Q+ShqTuUUwBNwiOop82T95BSVeNpB0sKxzvRiJaw/7siS+hy9WPjL7ZWqCzr167f/Y
         Wl/8hfp724uOe42GeT0aUg7P7a0c4CxhwF4Keka6cXSno7ubKRJCFPi+klSARPaNZjBC
         dnwHUytMhqF/8MlwHVtcIIeGkui8eEe5FZQJnYHePbwr/SDnGYLV1BoqkXxsm9TAKhsg
         FKXi5b2VdqCUc2AkvrjdeGa1KANAqjwIo59kN/oR1rhunnZzO7B6+cwo4mrAQUtxUqYs
         A5Nw==
X-Gm-Message-State: APjAAAWXA4QJEI+KRo6eIyxOqoZ0dhebWUQ68GGqA2Lo/XTqiPOEArfJ
        qOqem/wzLVtaILeUxAAYwzo=
X-Google-Smtp-Source: APXvYqy6QP8PtjcfkioSt7+66/de3FwELV/kF4ADw0lzESr7POOgv/jRoeZMQuL9GlEbjqP/VtVpnQ==
X-Received: by 2002:ac8:5042:: with SMTP id h2mr20098496qtm.96.1562767924027;
        Wed, 10 Jul 2019 07:12:04 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:2bbe])
        by smtp.gmail.com with ESMTPSA id r4sm1789171qta.93.2019.07.10.07.12.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 07:12:03 -0700 (PDT)
Date:   Wed, 10 Jul 2019 07:12:00 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Corey Minyard <minyard@acm.org>
Cc:     openipmi-developer@lists.sourceforge.net, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: Re: [Openipmi-developer] [PATCH] ipmi_si_intf: use usleep_range()
 instead of busy looping
Message-ID: <20190710141200.GN657710@devbig004.ftw2.facebook.com>
References: <20190709210643.GJ657710@devbig004.ftw2.facebook.com>
 <20190709214602.GD19430@minyard.net>
 <20190709221147.GM657710@devbig004.ftw2.facebook.com>
 <20190709230703.GF19430@minyard.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709230703.GF19430@minyard.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Corey.

On Tue, Jul 09, 2019 at 06:07:03PM -0500, Corey Minyard wrote:
> I believe the change was 33979734cd35ae "IPMI: use schedule in kthread"
> The original change that added the kthread was a9a2c44ff0a1350
> "ipmi: add timer thread".
> 
> I mis-remembered this, we switched from doing a udelay() to
> schedule(), but that udelay was 1us, so that's probably not helpful
> information.

I see, so it went from non-yielding busy looping to an yiedling one.
And, yeah, udelay(1) isn't much of a data point.

Thanks.

-- 
tejun
