Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD095F393E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 21:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfKGUK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 15:10:56 -0500
Received: from ms.lwn.net ([45.79.88.28]:39460 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbfKGUKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 15:10:53 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D35BD2C1;
        Thu,  7 Nov 2019 20:10:52 +0000 (UTC)
Date:   Thu, 7 Nov 2019 13:10:51 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>
Subject: Re: [PATCH] docs: printk-formats: add ptrdiff_t type to
 printk-formats
Message-ID: <20191107131051.61308a05@lwn.net>
In-Reply-To: <20191001100449.19481-1-miles.chen@mediatek.com>
References: <20191001100449.19481-1-miles.chen@mediatek.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Oct 2019 18:04:49 +0800
Miles Chen <miles.chen@mediatek.com> wrote:

> When print the difference between two pointers, we should use
> the ptrdiff_t modifier %t.
> 
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> ---
>  Documentation/core-api/printk-formats.rst | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Applied, thanks.

jon
