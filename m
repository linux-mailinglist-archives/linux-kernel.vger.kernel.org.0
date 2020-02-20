Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C414166772
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 20:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbgBTTrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 14:47:32 -0500
Received: from muru.com ([72.249.23.125]:56494 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728514AbgBTTrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 14:47:32 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 0D3C48080;
        Thu, 20 Feb 2020 19:48:16 +0000 (UTC)
Date:   Thu, 20 Feb 2020 11:47:29 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: mfd: motmdm: Add binding for
 motorola-mdm
Message-ID: <20200220194729.GU37466@atomide.com>
References: <20200219170106.38543-1-tony@atomide.com>
 <20200219170106.38543-4-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219170106.38543-4-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [700101 00:00]:
> Add a binding document for Motorola modems controllable by
> TS 27.010 UART line discipline using serdev drivers.

FYI, this patch needs updating for the license and to drop
the pointless "allOf" from the binding based on Rob's comments
from yesterday for v2 of this series.

Regards,

Tony
