Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2BC46A143
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 06:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfGPEPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 00:15:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:51856 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726502AbfGPEPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 00:15:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 28DB8AFD2;
        Tue, 16 Jul 2019 04:15:31 +0000 (UTC)
Subject: Re: [PATCH v2] x86/paravirt: Drop {read,write}_cr8() hooks
To:     Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Stephane Eranian <eranian@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        FengTang <feng.tang@intel.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        virtualization@lists.linux-foundation.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        PavelMachek <pavel@ucw.cz>, Nadav Amit <namit@vmware.com>
References: <20190715151641.29210-1-andrew.cooper3@citrix.com>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <49462c78-f0ad-cb18-7cc7-2a3ce20c7006@suse.com>
Date:   Tue, 16 Jul 2019 06:15:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190715151641.29210-1-andrew.cooper3@citrix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.07.19 17:16, Andrew Cooper wrote:
> There is a lot of infrastructure for functionality which is used
> exclusively in __{save,restore}_processor_state() on the suspend/resume
> path.
> 
> cr8 is an alias of APIC_TASKPRI, and APIC_TASKPRI is saved/restored by
> lapic_{suspend,resume}().  Saving and restoring cr8 independently of the
> rest of the Local APIC state isn't a clever thing to be doing.
> 
> Delete the suspend/resume cr8 handling, which shrinks the size of struct
> saved_context, and allows for the removal of both PVOPS.
> 
> Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
