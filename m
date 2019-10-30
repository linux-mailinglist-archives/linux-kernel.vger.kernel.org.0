Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68598EA566
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 22:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfJ3VdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Oct 2019 17:33:21 -0400
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:57535 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfJ3VdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 17:33:21 -0400
Received: from belgarion ([90.55.204.252])
        by mwinf5d15 with ME
        id KxZJ2100D5TFNlm03xZJLu; Wed, 30 Oct 2019 22:33:19 +0100
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Wed, 30 Oct 2019 22:33:19 +0100
X-ME-IP: 90.55.204.252
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 42/46] ARM: pxa: remove unused mach/bitfield.h
References: <20191018154052.1276506-1-arnd@arndb.de>
        <20191018154201.1276638-42-arnd@arndb.de>
X-URL:  http://belgarath.falguerolles.org/
Date:   Wed, 30 Oct 2019 22:33:18 +0100
In-Reply-To: <20191018154201.1276638-42-arnd@arndb.de> (Arnd Bergmann's
        message of "Fri, 18 Oct 2019 17:41:57 +0200")
Message-ID: <871rutnckh.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/26 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> The sa1111.h header defines some constants using the bitfield
> macros, but those are only used on sa1100, not on pxa, and the
> users include the bitfield header through mach/hardware.h.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
As long as a dependency of sa1111.h was not assuming these bitfield macros
existed and is now broken :
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
