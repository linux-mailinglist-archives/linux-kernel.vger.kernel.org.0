Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB34E1E31
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 16:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406323AbfJWOa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 10:30:59 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38017 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2403845AbfJWOa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 10:30:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571841058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2VjSorhOuc9UCrlZzlLM8XD5fgipJEwO0zoV+pcgad4=;
        b=PliAV2FYbevwwyM6dkmwPGIcFPgPJXampgSWErrMRCRz4ZO5oO6zF3JvMatUhdN3vCu9Py
        TXXjfcvsYavjLgsXC2dP5eyu/KWnHStY9ezSQlO6ztE6/CCiigKC/kWadrhkCfFdwAuYax
        R5ODZ0/OKcu80jvYSR9onWcqEIUMXr0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-amZsD0HRNKeg2CfEQMEMQA-1; Wed, 23 Oct 2019 10:30:54 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 123095E6;
        Wed, 23 Oct 2019 14:30:52 +0000 (UTC)
Received: from krava (ovpn-204-191.brq.redhat.com [10.40.204.191])
        by smtp.corp.redhat.com (Postfix) with SMTP id 64DEA1001B05;
        Wed, 23 Oct 2019 14:30:50 +0000 (UTC)
Date:   Wed, 23 Oct 2019 16:30:49 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Andi Kleen <andi@firstfloor.org>, acme@kernel.org,
        linux-kernel@vger.kernel.org, jolsa@kernel.org, eranian@google.com,
        kan.liang@linux.intel.com, peterz@infradead.org
Subject: Re: [PATCH v2 4/9] perf affinity: Add infrastructure to save/restore
 affinity
Message-ID: <20191023143049.GS22919@krava>
References: <20191020175202.32456-1-andi@firstfloor.org>
 <20191020175202.32456-5-andi@firstfloor.org>
 <20191023095911.GJ22919@krava>
 <20191023130235.GF4660@tassilo.jf.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191023130235.GF4660@tassilo.jf.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: amZsD0HRNKeg2CfEQMEMQA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 06:02:35AM -0700, Andi Kleen wrote:
> On Wed, Oct 23, 2019 at 11:59:11AM +0200, Jiri Olsa wrote:
> > On Sun, Oct 20, 2019 at 10:51:57AM -0700, Andi Kleen wrote:
> >=20
> > SNIP
> >=20
> > > +}
> > > diff --git a/tools/perf/util/affinity.h b/tools/perf/util/affinity.h
> > > new file mode 100644
> > > index 000000000000..e56148607e33
> > > --- /dev/null
> > > +++ b/tools/perf/util/affinity.h
> > > @@ -0,0 +1,15 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +#ifndef AFFINITY_H
> > > +#define AFFINITY_H 1
> > > +
> > > +struct affinity {
> > > +=09unsigned char *orig_cpus;
> > > +=09unsigned char *sched_cpus;
> >=20
> > why not use cpu_set_t directly?
>=20
> Because it's too small in glibc (only 1024 CPUs) and perf already=20
> supports more.

nice, we're using it all over the place.. how about using bitmap_alloc?

jirka

