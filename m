Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F51318CDCF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 13:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgCTMV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 08:21:27 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:36891 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbgCTMV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 08:21:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds201912; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5iMx0vXtQgR8ttF1pDsJGR7JeKT+xrFie+T+HU+y5d0=; b=NZx8x+TAYyKNAmmrk49tIU4Yfp
        792owegak03W4T7aCHC6n6ZQvkDThxqk8TYM4/tpL877rD3bTiJf5USL4iNpwqGuMEAJVl9sVvUbV
        aCZmDHAAnpXW52VuUcqw5Nh31xNYqhstFGUu9ZrtK1aWRJeNoRCN21o71pR007sUmJTY2qNHJNaIF
        kifAYsqwKQSPStxjKxMPx+cn1d9BZL5o+SVd3xWfBuTT7vzCKqP6nCvE7T933uJD47QryWbuOc7Pe
        cv3PwBAjIDaAuAMknzASLFSPysiAaa+lvo551H2LGIPxSneY4jF7vYWay06uB/Q4aqC2dDlfvQ44n
        ZogxpAxw==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:51027 helo=[192.168.10.61])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1jFGeT-0004O0-AF; Fri, 20 Mar 2020 13:21:25 +0100
Subject: Re: [PATCH 2/2] drm/format_helper: Dual licence the header in GPL-2
 and MIT
To:     Emmanuel Vadot <manu@FreeBSD.org>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        matthew.d.roper@intel.com, kraxel@redhat.com, tglx@linutronix.de
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200320022114.2234-1-manu@FreeBSD.org>
 <20200320022114.2234-2-manu@FreeBSD.org>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <eb1c122e-808e-1dd4-b15b-b7edbc50e0be@tronnes.org>
Date:   Fri, 20 Mar 2020 13:21:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200320022114.2234-2-manu@FreeBSD.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 20.03.2020 03.21, skrev Emmanuel Vadot:
> Source file was dual licenced but the header was omitted, fix that.
> Contributors for this file are:
> Noralf Trønnes <noralf@tronnes.org>
> Gerd Hoffmann <kraxel@redhat.com>
> Thomas Gleixner <tglx@linutronix.de>
> 
> Signed-off-by: Emmanuel Vadot <manu@FreeBSD.org>
> ---

Acked-by: Noralf Trønnes <noralf@tronnes.org>
