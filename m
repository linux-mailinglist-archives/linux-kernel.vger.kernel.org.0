Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B50A393BC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2019 19:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731039AbfFGR5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jun 2019 13:57:15 -0400
Received: from ms.lwn.net ([45.79.88.28]:58004 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729714AbfFGR5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 13:57:15 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 85999737;
        Fri,  7 Jun 2019 17:57:14 +0000 (UTC)
Date:   Fri, 7 Jun 2019 11:57:13 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     <lecopzer.chen@mediatek.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <mhiramat@kernel.org>, <srv_heupstream@mediatek.com>,
        <yj.chiang@mediatek.com>
Subject: Re: [PATCH] Documentation: {u,k}probes: add tracing_on before
 tracing
Message-ID: <20190607115713.7b5134e2@lwn.net>
In-Reply-To: <1557397876-18153-1-git-send-email-lecopzer.chen@mediatek.com>
References: <1557397876-18153-1-git-send-email-lecopzer.chen@mediatek.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 May 2019 18:31:16 +0800
<lecopzer.chen@mediatek.com> wrote:

> From: Lecopzer Chen <lecopzer.chen@mediatek.com>
> 
> After following the document step by step, the `cat trace` can't be
> worked without enabling tracing_on and might mislead newbies about
> the functionality.
> 
> Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>

Applied, thanks.

jon
