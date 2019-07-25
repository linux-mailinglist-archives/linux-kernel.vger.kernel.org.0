Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A98374941
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 10:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389829AbfGYIlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 04:41:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45605 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389213AbfGYIlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 04:41:03 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hqZJ7-0001IK-75; Thu, 25 Jul 2019 10:41:01 +0200
Date:   Thu, 25 Jul 2019 10:41:00 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
cc:     linux-kernel@vger.kernel.org, linux-spdx@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 3/3] iomap: fix Invalid License ID
In-Reply-To: <20190725075833.3481-3-yamada.masahiro@socionext.com>
Message-ID: <alpine.DEB.2.21.1907251040380.1791@nanos.tec.linutronix.de>
References: <20190725075833.3481-1-yamada.masahiro@socionext.com> <20190725075833.3481-3-yamada.masahiro@socionext.com>
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

On Thu, 25 Jul 2019, Masahiro Yamada wrote:

> Detected by:
> 
>   $ ./scripts/spdxcheck.py
>   fs/iomap/Makefile: 1:27 Invalid License ID: GPL-2.0-or-newer
> 
> Fixes: 1c230208f53d ("iomap: start moving code to fs/iomap/")
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
