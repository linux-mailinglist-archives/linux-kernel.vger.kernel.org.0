Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35C763D727
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 21:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406313AbfFKTr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 15:47:59 -0400
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:60229 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389150AbfFKTr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:47:59 -0400
Received: from belgarion ([90.76.40.119])
        by mwinf5d16 with ME
        id PXnq2000B2aFDoA03XnqEQ; Tue, 11 Jun 2019 21:47:57 +0200
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Tue, 11 Jun 2019 21:47:57 +0200
X-ME-IP: 90.76.40.119
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Olof Johansson <olof@lixom.net>, Wei Xu <xuwei5@hisilicon.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] ARM: pxa: Switch to SPDX header
References: <20190611072921.2979446-1-lkundrak@v3.sk>
        <20190611072921.2979446-6-lkundrak@v3.sk>
X-URL:  http://belgarath.falguerolles.org/
Date:   Tue, 11 Jun 2019 21:47:50 +0200
In-Reply-To: <20190611072921.2979446-6-lkundrak@v3.sk> (Lubomir Rintel's
        message of "Tue, 11 Jun 2019 09:29:20 +0200")
Message-ID: <87tvcv3nvd.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/26 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lubomir Rintel <lkundrak@v3.sk> writes:

> The original license text had a typo ("publishhed") which would be
> likely to confuse automated licensing auditing tools. Let's just switch
> to SPDX instead of fixing the wording.
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
