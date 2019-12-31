Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD5212D876
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Dec 2019 12:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfLaLwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Dec 2019 06:52:50 -0500
Received: from gloria.sntech.de ([185.11.138.130]:53016 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726334AbfLaLwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 06:52:49 -0500
Received: from [217.166.244.239] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1imG4r-0003rw-K3; Tue, 31 Dec 2019 12:52:45 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: rk3368-lion-haikou: remove identical &uart0 node
Date:   Tue, 31 Dec 2019 12:47:36 +0100
Message-ID: <1957883.kUPM6Xjvq3@phil>
In-Reply-To: <20191228074757.2075-1-jbx6244@gmail.com>
References: <20191220125520.29871-1-jbx6244@gmail.com> <20191228074757.2075-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

Am Samstag, 28. Dezember 2019, 08:47:57 CET schrieb Johan Jonker:
> There are two identical &uart0 nodes in this dts file,
> so remove one of them.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
thanks for separating the duplicate-removal from the other changes
and I've applied the patch for 5.6 now.

Thanks
Heiko


