Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE20FB8F11
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2019 13:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408746AbfITLjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Sep 2019 07:39:55 -0400
Received: from 9.mo173.mail-out.ovh.net ([46.105.72.44]:58922 "EHLO
        9.mo173.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406069AbfITLjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 07:39:54 -0400
Received: from player756.ha.ovh.net (unknown [10.108.35.74])
        by mo173.mail-out.ovh.net (Postfix) with ESMTP id B7FA811A2EB
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 13:23:17 +0200 (CEST)
Received: from qperret.net (115.ip-51-255-42.eu [51.255.42.115])
        (Authenticated sender: qperret@qperret.net)
        by player756.ha.ovh.net (Postfix) with ESMTPSA id 031809391DBA;
        Fri, 20 Sep 2019 11:23:04 +0000 (UTC)
Date:   Fri, 20 Sep 2019 13:23:00 +0200
From:   Quentin Perret <qperret@qperret.net>
To:     Pavan Kondeti <pkondeti@codeaurora.org>
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com, rjw@rjwysocki.net,
        morten.rasmussen@arm.com, valentin.schneider@arm.com,
        qais.yousef@arm.com, tkjos@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Speed-up energy-aware wake-ups
Message-ID: <20190920112300.GA13151@qperret.net>
References: <20190912094404.13802-1-qperret@qperret.net>
 <20190920030215.GA20250@codeaurora.org>
 <20190920094115.GA11503@qperret.net>
 <20190920103338.GB20250@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920103338.GB20250@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Ovh-Tracer-Id: 13160925489703639961
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvddvgdefjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 20 Sep 2019 at 16:03:38 (+0530), Pavan Kondeti wrote:
> +1. Looks good to me.

Cool, thanks.

Peter/Ingo, is there anything else I should do ? Should I resend the
patch 'properly' (that is, not inline) ?

Thanks,
Quentin
