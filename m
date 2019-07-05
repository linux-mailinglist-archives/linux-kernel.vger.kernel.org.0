Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9931605C9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2019 14:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbfGEMPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jul 2019 08:15:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34668 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfGEMPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 08:15:00 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hjN7A-0006lP-Gn; Fri, 05 Jul 2019 14:14:56 +0200
Date:   Fri, 5 Jul 2019 14:14:55 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     zhengbin <zhengbin13@huawei.com>
cc:     john.stultz@linaro.org, sboyd@kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        zhangxiaoxu5@huawei.com
Subject: Re: [PATCH] time: compat settimeofday: Validate the values of tv
 from user
In-Reply-To: <1562318088-37669-1-git-send-email-zhengbin13@huawei.com>
Message-ID: <alpine.DEB.2.21.1907051230340.1802@nanos.tec.linutronix.de>
References: <1562318088-37669-1-git-send-email-zhengbin13@huawei.com>
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

Zhengbin,

On Fri, 5 Jul 2019, zhengbin wrote:

> Similar to commit 6ada1fc0e1c4
> ("time: settimeofday: Validate the values of tv from user"),
> an unvalidated user input is multiplied by a constant, which can result
> in an undefined behaviour for large values. While this is validated
> later, we should avoid triggering undefined behaviour.

I surely agree with the patch, but the argument that this is validated
later and we just should avoid UB in general is just wrong.

For a wide range of negative tv_usec values the multiplication overflow
turns them in positive numbers. So the 'validated later' is not catching
the invalid input.

So 'should avoid ....' is just the wrong argument here.

Validation _is_ required before the multiplication so UB won't turn an
invalid value into a valid one.

Thanks,

	tglx
