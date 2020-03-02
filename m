Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7051E175E54
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 16:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbgCBPir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 10:38:47 -0500
Received: from foss.arm.com ([217.140.110.172]:34160 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbgCBPir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 10:38:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC6732F;
        Mon,  2 Mar 2020 07:38:46 -0800 (PST)
Received: from [10.1.195.32] (e112269-lin.cambridge.arm.com [10.1.195.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E5EE3F534;
        Mon,  2 Mar 2020 07:38:46 -0800 (PST)
Subject: Re: [PATCH v2] drm: panfrost: Silence warnings during deferred probe
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
References: <CGME20200228094033eucas1p2fa2f6cea3b882e758992d97da2fc50ed@eucas1p2.samsung.com>
 <20200228094026.26983-1-m.szyprowski@samsung.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <8a4249f4-77cd-d46c-5390-4b821873831d@arm.com>
Date:   Mon, 2 Mar 2020 15:38:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200228094026.26983-1-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/2020 09:40, Marek Szyprowski wrote:
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Reviewed-by: Steven Price <steven.price@arm.com>
