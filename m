Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4586217E561
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 18:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbgCIRKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 13:10:07 -0400
Received: from foss.arm.com ([217.140.110.172]:54890 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726804AbgCIRKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 13:10:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73BE11FB;
        Mon,  9 Mar 2020 10:10:06 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B598E3F534;
        Mon,  9 Mar 2020 10:10:04 -0700 (PDT)
Date:   Mon, 9 Mar 2020 17:10:02 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     =?utf-8?B?546L56iL5Yia?= <wangchenggang@vivo.com>
Cc:     'Will Deacon' <will@kernel.org>,
        'Mark Rutland' <mark.rutland@arm.com>,
        'Marc Zyngier' <maz@kernel.org>,
        'Allison Randal' <allison@lohutok.net>,
        'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        'Andrew Murray' <amurray@thegoodpenguin.co.uk>,
        'Thomas Gleixner' <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org, wenhu.wang@vivo.com
Subject: Re: [PATCH] arch/arm64: fix typo in a comment
Message-ID: <20200309171002.GD4124965@arrakis.emea.arm.com>
References: <000401d5f5e3$622aefa0$2680cee0$@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <000401d5f5e3$622aefa0$2680cee0$@vivo.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 03:21:42PM +0800, 王程刚 wrote:
> Fix typo in a comment in arch/arm64/include/asm/esr.h
> 
> "Unallocted" -> "Unallocated"
> 
> Signed-off-by: Chenggang Wang <wangchenggang@vivo.com>

Queued for 5.7. Thanks.

-- 
Catalin
