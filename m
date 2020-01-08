Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBFEC133D5F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 09:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbgAHIlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 03:41:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:60216 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbgAHIlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 03:41:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B6907ACE3;
        Wed,  8 Jan 2020 08:40:59 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Greentime Hu <greentime.hu@sifive.com>
Cc:     green.hu@gmail.com, greentime@kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] riscv: to make sure the cores in .Lsecondary_park
References: <20200108024035.17524-1-greentime.hu@sifive.com>
X-Yow:  I will invent "TIDY BOWL"...
Date:   Wed, 08 Jan 2020 09:40:58 +0100
In-Reply-To: <20200108024035.17524-1-greentime.hu@sifive.com> (Greentime Hu's
        message of "Wed, 8 Jan 2020 10:40:35 +0800")
Message-ID: <mvmk162z6g5.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The subject is missing a verb.

riscv: make sure the cores stay looping in .Lsecondary_park

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
