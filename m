Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 955BD16AE58
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 19:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgBXSIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 13:08:23 -0500
Received: from ms.lwn.net ([45.79.88.28]:46780 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727438AbgBXSIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 13:08:23 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 685FF2ED;
        Mon, 24 Feb 2020 18:08:20 +0000 (UTC)
Date:   Mon, 24 Feb 2020 11:08:15 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Cc:     linux-doc@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: process: changes.rst: Escape --version to fix
 Sphinx output
Message-ID: <20200224110815.6f7561d1@lwn.net>
In-Reply-To: <20200223222228.27089-1-j.neuschaefer@gmx.net>
References: <20200223222228.27089-1-j.neuschaefer@gmx.net>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Feb 2020 23:22:27 +0100
Jonathan Neuschäfer <j.neuschaefer@gmx.net> wrote:

> Without double-backticks, Sphinx wrongly turns "--version" into
> "–version" with a Unicode EN DASH (U+2013), that is visually easy to
> confuse with a single ASCII dash.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

This certainly seems worth addressing.  But I would *really* rather find
a way to tell Sphinx not to do that rather than making all of these
tweaks - which we will certainly find ourselves having to do over and
over again.  I can try to look into that in a bit, but if somebody were
to beat me to it ... :)

Thanks,

jon
