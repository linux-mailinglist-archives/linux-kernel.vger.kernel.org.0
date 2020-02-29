Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A430517473D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Feb 2020 15:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgB2OKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Feb 2020 09:10:51 -0500
Received: from mail.manjaro.org ([176.9.38.148]:35570 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726997AbgB2OKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 09:10:51 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id B0E383940EB1;
        Sat, 29 Feb 2020 15:10:49 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aebFSxlRHPMc; Sat, 29 Feb 2020 15:10:47 +0100 (CET)
Subject: Re: [PATCH v2 2/2] arm64: dts: rockchip: Add initial support for
 Pinebook Pro
To:     Johan Jonker <jbx6244@gmail.com>, t.schramm@manjaro.org
Cc:     aballier@gentoo.org, anarsoul@gmail.com, andy.yan@rock-chips.com,
        devicetree@vger.kernel.org, dianders@chromium.org, heiko@sntech.de,
        jagan@amarulasolutions.com, katsuhiro@katsuster.net,
        kever.yang@rock-chips.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        m.reichl@fivetechno.de, mark.rutland@arm.com, mka@chromium.org,
        nick@khadas.com, npcomplete13@gmail.com, robh+dt@kernel.org
References: <20200228203806.346299-3-t.schramm@manjaro.org>
 <68b8b201-d77a-7f91-fccd-8fec7eb15da5@gmail.com>
From:   Tobias Schramm <t.schramm@manjaro.org>
Message-ID: <8b3a8591-4b2c-fc6b-1693-b31e28e10817@manjaro.org>
Date:   Sat, 29 Feb 2020 15:05:35 +0100
MIME-Version: 1.0
In-Reply-To: <68b8b201-d77a-7f91-fccd-8fec7eb15da5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

thanks for the review. I'll include your fixes in v3.


Tobias
