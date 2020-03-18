Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB6C118A1FF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 18:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgCRR5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Mar 2020 13:57:12 -0400
Received: from foss.arm.com ([217.140.110.172]:52872 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbgCRR5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 13:57:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D09A01FB;
        Wed, 18 Mar 2020 10:57:11 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 11E303F67D;
        Wed, 18 Mar 2020 10:57:10 -0700 (PDT)
Date:   Wed, 18 Mar 2020 17:57:09 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     =?iso-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>
Cc:     will@kernel.org, linux-arm-kernel@lists.infradead.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: clean up trampoline vector loads
Message-ID: <20200318175709.GD94111@arrakis.emea.arm.com>
References: <20200316124046.103844-1-remi@remlab.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200316124046.103844-1-remi@remlab.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 02:40:44PM +0200, Rémi Denis-Courmont wrote:
> From: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
> 
> This switches from custom instruction patterns to the regular large
> memory model sequence with ADRP and LDR. In doing so, the ADD
> instruction can be eliminated in the SDEI handler, and the code no
> longer assumes that the trampoline vectors and the vectors address both
> start on a page boundary.
> 
> Signed-off-by: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>

I queued the 3 trampoline patches for 5.7. Thanks.

-- 
Catalin
