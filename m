Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8A168A5C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2019 15:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730209AbfGONXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jul 2019 09:23:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:51232 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730071AbfGONXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 09:23:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 11051AF25;
        Mon, 15 Jul 2019 13:22:59 +0000 (UTC)
Subject: Re: [PATCH] x86/paravirt: Drop {read,write}_cr8() hooks
To:     Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Stephane Eranian <eranian@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        FengTang <feng.tang@intel.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        virtualization@lists.linux-foundation.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Rafael J.Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Alok Kataria <akataria@vmware.com>,
        Nadav Amit <namit@vmware.com>
References: <20190715130056.10627-1-andrew.cooper3@citrix.com>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <a04918d1-975e-5869-1ecd-c9df4ae5b1c1@suse.com>
Date:   Mon, 15 Jul 2019 15:22:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190715130056.10627-1-andrew.cooper3@citrix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.07.19 15:00, Andrew Cooper wrote:
> There is a lot of infrastructure for functionality which is used
> exclusively in __{save,restore}_processor_state() on the suspend/resume
> path.
> 
> cr8 is an alias of APIC_TASKPRI, and APIC_TASKPRI is saved/restored
> independently by lapic_{suspend,resume}().

Aren't those called only with CONFIG_PM set?


Juergen
