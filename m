Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF94CEC5B0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2019 16:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbfKAPgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Nov 2019 11:36:12 -0400
Received: from foss.arm.com ([217.140.110.172]:37562 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727100AbfKAPgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 11:36:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3429031F;
        Fri,  1 Nov 2019 08:36:11 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.197.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4BB143F719;
        Fri,  1 Nov 2019 08:36:10 -0700 (PDT)
Date:   Fri, 1 Nov 2019 15:36:08 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Julien Grall <julien@xen.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, suzuki.poulose@arm.com,
        Julien Grall <julien.grall@arm.com>
Subject: Re: [PATCH] docs/arm64: cpu-feature-registers: Rewrite bitfields
 that don't follow [e, s]
Message-ID: <20191101153607.GF17207@arrakis.emea.arm.com>
References: <20191101152022.8853-1-julien@xen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101152022.8853-1-julien@xen.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2019 at 03:20:22PM +0000, Julien Grall wrote:
> From: Julien Grall <julien.grall@arm.com>
> 
> Commit "docs/arm64: cpu-feature-registers: Documents missing visible
> fields" added bitfiels following the convention [s, e]. However, the
> documentation is following [s, e] and so does the Arm ARM.
> 
> Rewrite the bitfields to match the format [e, s].
> 
> Signed-off-by: Julien Grall <julien.grall@arm.com>

Applied. Thanks.

-- 
Catalin
