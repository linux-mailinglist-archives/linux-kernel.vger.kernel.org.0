Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE4C20073
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 09:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfEPHmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 03:42:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:49746 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726363AbfEPHmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 03:42:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6E188AD49;
        Thu, 16 May 2019 07:42:02 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: fix locking violation in page fault handler
References: <mvm5zqmu35d.fsf@suse.de>
        <mhng-56794b7f-6cd4-4eb9-a962-83ad256ed3cd@palmer-si-x1e>
X-Yow:  Don't SANFORIZE me!!
Date:   Thu, 16 May 2019 09:42:01 +0200
In-Reply-To: <mhng-56794b7f-6cd4-4eb9-a962-83ad256ed3cd@palmer-si-x1e> (Palmer
        Dabbelt's message of "Tue, 07 May 2019 16:48:03 -0700 (PDT)")
Message-ID: <mvmy336luba.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mai 07 2019, Palmer Dabbelt <palmer@sifive.com> wrote:

> LMK if you, or anyone else, has a preference.  I'm assuming this will go in
> through my tree, so I've picked up my version for now :)

You did?

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
