Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 406C7A4D58
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2019 04:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbfIBCvv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 1 Sep 2019 22:51:51 -0400
Received: from ozlabs.org ([203.11.71.1]:41891 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729255AbfIBCvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 22:51:51 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46MF3P6ZMkz9sBF;
        Mon,  2 Sep 2019 12:51:45 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,
        linuxppc-dev@lists.ozlabs.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        Breno Leitao <leitao@debian.org>,
        Russell Currey <ruscur@russell.cc>,
        Nicolai Stange <nstange@suse.de>,
        Michael Neuling <mikey@neuling.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Brauner <christian@brauner.io>,
        David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 6/6] powerpc/perf: split callchain.c by bitness
In-Reply-To: <20190830210645.78931423@kitsune.suse.cz>
References: <cover.1567188299.git.msuchanek@suse.de> <567e7e876edf29ae528027d8574038fbc287f25a.1567188299.git.msuchanek@suse.de> <20190830210645.78931423@kitsune.suse.cz>
Date:   Mon, 02 Sep 2019 12:51:42 +1000
Message-ID: <87d0gjtnpd.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Suchánek <msuchanek@suse.de> writes:
> On Fri, 30 Aug 2019 20:57:57 +0200
> Michal Suchanek <msuchanek@suse.de> wrote:
>
>> Building callchain.c with !COMPAT proved quite ugly with all the
>> defines. Splitting out the 32bit and 64bit parts looks better.
>> 
>
> BTW the powerpc callchain.c does not match any of the patterns of PERF
> CORE in MAINTAINERS (unlike callchain implementation on other
> platforms). Is that intentional?

No.

cheers
