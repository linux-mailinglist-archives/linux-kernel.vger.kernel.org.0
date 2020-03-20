Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF1E18CDCB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 13:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgCTMVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 08:21:13 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:45659 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbgCTMVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 08:21:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds201912; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=x50l/sk5zd5paFFA3ajk8EyOXhGzLL5WALi6QEatlVE=; b=R8xHqtKqqR07OlImYd06alORCe
        CZxY2Ljh9KKWwGGAakhP3TtYCbXvdOAxOHGIqzxfOLTLkZ5hHDPfEZsZItFFJki7SZWNOUaeMi75c
        Ke13Jimlo0bHjhJdnXlptn8QEgUdVEOBegwtZzPf59V6QzMjeLyU/XCVjrFNBAY19n1ji0O9Veo6P
        VHZq2dM7Cw026dRl/7scNHn/Cuk/shVcVOLpplWH1JTxCvjnXf3dycgItg+OsHNt9gOuob5rTpzLK
        40/Z5a0Y1Xwjh33N51hGAdZQyVvT+LDwqHO0O1Uc8L7ZFX7fjiJ64EQvlNllSgGvHwdq6kJmKOcCa
        xl7XjFQA==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:51023 helo=[192.168.10.61])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1jFGeE-00046l-Qp; Fri, 20 Mar 2020 13:21:10 +0100
Subject: Re: [PATCH 1/2] drm/client: Dual licence the header in GPL-2 and MIT
To:     Emmanuel Vadot <manu@FreeBSD.org>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        matthew.d.roper@intel.com, kraxel@redhat.com, tglx@linutronix.de
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200320022114.2234-1-manu@FreeBSD.org>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <5105e75b-3016-13d8-cbaf-1b3e9ecfaeb4@tronnes.org>
Date:   Fri, 20 Mar 2020 13:21:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200320022114.2234-1-manu@FreeBSD.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 20.03.2020 03.21, skrev Emmanuel Vadot:
> Source file was dual licenced but the header was omitted, fix that.
> Contributors for this file are:
> Daniel Vetter <daniel.vetter@ffwll.ch>
> Matt Roper <matthew.d.roper@intel.com>
> Maxime Ripard <mripard@kernel.org>
> Noralf Trønnes <noralf@tronnes.org>
> Thomas Zimmermann <tzimmermann@suse.de>
> 
> Signed-off-by: Emmanuel Vadot <manu@FreeBSD.org>
> ---

Acked-by: Noralf Trønnes <noralf@tronnes.org>
