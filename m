Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A09261C5F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2019 11:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbfGHJZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 05:25:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38883 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbfGHJZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 05:25:06 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hkPtM-0004vd-VP; Mon, 08 Jul 2019 11:25:01 +0200
Date:   Mon, 8 Jul 2019 11:24:59 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     ZhangXiaoxu <zhangxiaoxu5@huawei.com>
cc:     john.stultz@linaro.org, sboyd@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] time: Validate the usec before covert to nsec in
 do_adjtimex
In-Reply-To: <1562572504-142115-1-git-send-email-zhangxiaoxu5@huawei.com>
Message-ID: <alpine.DEB.2.21.1907081124000.3648@nanos.tec.linutronix.de>
References: <1562572504-142115-1-git-send-email-zhangxiaoxu5@huawei.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jul 2019, ZhangXiaoxu wrote:

> When covert the usec to nsec, it will multiple 1000, it maybe
> overflow and lead an undefined behavior.
> 
> For example, users may input an negative tv_usec values when
> call adjtimex syscall, then multiple 1000 maybe overflow it
> to a positive and legal number.
> 
> So, we should validate the usec before coverted it to nsec.

That's correct, but the actuall inject function wants to keep the sanity
check,

Thanks,

	tglx
