Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 470CD4CC40
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 12:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfFTKua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 06:50:30 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:34299 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726279AbfFTKu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 06:50:29 -0400
X-UUID: 4973fa4ee73a4525a25b99864c1ed2d1-20190620
X-UUID: 4973fa4ee73a4525a25b99864c1ed2d1-20190620
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 895874516; Thu, 20 Jun 2019 18:50:25 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 20 Jun 2019 18:50:23 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 20 Jun 2019 18:50:23 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <julien.thierry@arm.com>, <marc.zyngier@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>, <tglx@linutronix.de>,
        <peterz@infradead.org>, <yj.chiang@mediatek.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] genirq: Remove warning on preemptible in prepare_percpu_nmi()
Date:   Thu, 20 Jun 2019 18:50:24 +0800
Message-ID: <20190620105024.24935-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190620091233.22731-1-lecopzer.chen@mediatek.com>
References: <20190620091233.22731-1-lecopzer.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks a lot for reply!!

I just misunderstood how a PPI is registered and thought
I have a chance to eliminate the code.
This patch seems nonsense now, please ignore it.

Sorry to disturb you guys.


Thanks,
	Lecopzer
