Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DABF18D501
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 17:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbgCTQyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 12:54:49 -0400
Received: from foss.arm.com ([217.140.110.172]:53986 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726983AbgCTQys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 12:54:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 214C51FB;
        Fri, 20 Mar 2020 09:54:48 -0700 (PDT)
Received: from mbp (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D2403F305;
        Fri, 20 Mar 2020 09:54:47 -0700 (PDT)
Date:   Fri, 20 Mar 2020 16:54:44 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     =?iso-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 0/3] clean up KPTI / SDEI trampoline data alignment
Message-ID: <20200320165159.GB7448@mbp>
References: <1938400.7m7sAWtiY1@basile.remlab.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1938400.7m7sAWtiY1@basile.remlab.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 11:12:56AM +0200, Rémi Denis-Courmont wrote:
> 	Hi,
> 
> The KPTI and SDE trampolines each load a pointer from the same fixmap data
> page. This reduces the data alignment to the useful value, and tries to
> clarify the assembler code.
> 
> Changes since v2:
> - Retain alignment even when SDEI is disabled to keep ld happy.

I queued v2. Thanks.

-- 
Catalin
