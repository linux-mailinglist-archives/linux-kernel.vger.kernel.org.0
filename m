Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFD314F50E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Feb 2020 00:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgAaXCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jan 2020 18:02:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:44520 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbgAaXCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 18:02:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5794EB15E;
        Fri, 31 Jan 2020 23:02:49 +0000 (UTC)
Date:   Sat, 1 Feb 2020 00:02:42 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Steven Clarkson <sc@lambdal.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/boot: Handle malformed SRAT tables during early ACPI
 parsing
Message-ID: <20200131230240.GE14851@zn.tnic>
References: <CAHKq8taGzj0u1E_i=poHUam60Bko5BpiJ9jn0fAupFUYexvdUQ@mail.gmail.com>
 <20200131185531.GC14851@zn.tnic>
 <CAE8Va4ftJBFpHv1kENyRhed5EGFgopNM2TpxwYC8psJCrnPBAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE8Va4ftJBFpHv1kENyRhed5EGFgopNM2TpxwYC8psJCrnPBAw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 03:00:49PM -0800, Steven Clarkson wrote:
> I did that, but my mail client ate my tabs. Lesson learned. Thanks.

We have some info for mail clients too:

https://www.kernel.org/doc/html/latest/process/email-clients.html

HTH.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
