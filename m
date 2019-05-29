Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 119982DD58
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 14:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfE2MlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 08:41:24 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45292 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbfE2MlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 08:41:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF08780D;
        Wed, 29 May 2019 05:41:23 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 88A2E3F59C;
        Wed, 29 May 2019 05:41:22 -0700 (PDT)
Date:   Wed, 29 May 2019 13:41:20 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH 0/4] arm64/mm: Fixes and cleanups for do_page_fault()
Message-ID: <20190529124120.GF4485@fuggles.cambridge.arm.com>
References: <1559133285-27986-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559133285-27986-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

On Wed, May 29, 2019 at 06:04:41PM +0530, Anshuman Khandual wrote:
> This series contains some fixes and cleanups for page fault handling in
> do_page_fault(). This has been boot tested on arm64 platform along with
> some stress test but just build tested on others.

These all seem to be cleanups, which is fine, but I just wanted to make
sure I'm not missing something that should be aiming for 5.2. Are there
actually fixes in this series?

(in future, it's best to post fixes separately so I don't miss them)

Cheers,

Will
