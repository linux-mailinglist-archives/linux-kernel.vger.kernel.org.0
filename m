Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 102976991C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2019 18:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731196AbfGOQbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jul 2019 12:31:06 -0400
Received: from mga12.intel.com ([192.55.52.136]:47500 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729533AbfGOQbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 12:31:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jul 2019 09:31:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,493,1557212400"; 
   d="scan'208";a="167382269"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga008.fm.intel.com with ESMTP; 15 Jul 2019 09:31:05 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id D2E89301AE9; Mon, 15 Jul 2019 09:31:05 -0700 (PDT)
From:   Andi Kleen <ak@linux.intel.com>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH, x86]: Disable CPA cache flush for selfsnoop targets
References: <CAFULd4b=5-=WfF9OPCX+H9VDnsgbN7OBFj-XP=MZ0QqF5WpvQA@mail.gmail.com>
Date:   Mon, 15 Jul 2019 09:31:05 -0700
In-Reply-To: <CAFULd4b=5-=WfF9OPCX+H9VDnsgbN7OBFj-XP=MZ0QqF5WpvQA@mail.gmail.com>
        (Uros Bizjak's message of "Thu, 11 Jul 2019 10:12:55 +0200")
Message-ID: <8736j7gsza.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uros Bizjak <ubizjak@gmail.com> writes:

> Recent patch [1] disabled a self-snoop feature on a list of processor
> models with a known errata, so we are confident that the feature
> should work on remaining models also for other purposes than to speed
> up MTRR programming.

MTRR is very different than TLBs.

From my understanding not flushing with PAT is only safe everywhere when
the memory is only used for coherent devices (like the Internal GPU on
Intel CPUs). We don't have any infrastructure to track or enforce
this unfortunately.

-Andi
