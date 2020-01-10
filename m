Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B135D137529
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 18:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbgAJRrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 12:47:23 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59054 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728224AbgAJRrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:47:22 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ipyNU-0001YK-IY; Fri, 10 Jan 2020 18:47:20 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 1A65D105BDB; Fri, 10 Jan 2020 18:47:20 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org,
        Deepa Dinamani <deepa.kernel@gmail.com>
Subject: Re: [PATCH 2/3] y2038: remove unused time32 interfaces
In-Reply-To: <20200110154232.4104492-3-arnd@arndb.de>
References: <20200110154232.4104492-1-arnd@arndb.de> <20200110154232.4104492-3-arnd@arndb.de>
Date:   Fri, 10 Jan 2020 18:47:20 +0100
Message-ID: <87v9pjqk47.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> No users remain, so kill these off before we grow new ones.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Thomas Gleixner <tglx@linutronix.de>

