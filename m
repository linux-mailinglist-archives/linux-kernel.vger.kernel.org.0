Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6536916569
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 16:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfEGOMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 10:12:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:46400 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726063AbfEGOMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 10:12:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D9DA2AE47;
        Tue,  7 May 2019 14:12:08 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: fix locking violation in page fault handler
References: <mvm5zqmu35d.fsf@suse.de>
        <b2030f8c-010e-7088-271e-e2398f7d37db@suse.com>
X-Yow:  A dwarf is passing out somewhere in Detroit!
Date:   Tue, 07 May 2019 16:12:08 +0200
In-Reply-To: <b2030f8c-010e-7088-271e-e2398f7d37db@suse.com> (Nikolay
        Borisov's message of "Tue, 7 May 2019 11:04:58 +0300")
Message-ID: <mvmmujyqrpj.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mai 07 2019, Nikolay Borisov <nborisov@suse.com> wrote:

> At the very least the code under
> no_context label could go into it's own function since it just kills the
> process and never returns?

This is not true.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
