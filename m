Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2835E2C0B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 10:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438149AbfJXIYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 04:24:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42083 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725947AbfJXIYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 04:24:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571905453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bo34zTC4JQ2tsdZbu5ywIVsmasMMdr8/hfrAnn7U7ck=;
        b=bUDsC0IamBLXKjTWG6aPzv99/jGGFLmGWRG84jXjK8Mwztg98u8dq8X+kUBzAnx7oiM315
        IJmgHsCyOydXzFSVZLlTPjnG2hqhjnNB1zjCa35axoQ/XYJPsVWfNTH/bTiG1BphLGStBY
        kVua7FjY6znJ7sCOgcEXWVyYLKmeGew=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-kCkzpfhJN_2YbO2fmoU_qQ-1; Thu, 24 Oct 2019 04:24:07 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA8FB1800DCA;
        Thu, 24 Oct 2019 08:24:05 +0000 (UTC)
Received: from krava (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1174D600C4;
        Thu, 24 Oct 2019 08:24:01 +0000 (UTC)
Date:   Thu, 24 Oct 2019 10:24:01 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Igor Lubashev <ilubashe@akamai.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] perf: Allow running without stdin
Message-ID: <20191024082401.GA13378@krava>
References: <1571795693-23558-1-git-send-email-ilubashe@akamai.com>
MIME-Version: 1.0
In-Reply-To: <1571795693-23558-1-git-send-email-ilubashe@akamai.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: kCkzpfhJN_2YbO2fmoU_qQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 09:54:50PM -0400, Igor Lubashev wrote:
> This series allows perf to run in batch mode with stdin closed.
> This is arguably a bug fix for code that runs with --stdio option and doe=
s not
> check for EOF return code from getc().
>=20
> This series makes the following work as expected:
>=20
>   $ perf top --stdio < /dev/null
>   $ perf kvm top --stdio < /dev/null
>=20
> Patches:
>   01: perf top: Allow running without stdin
>     Make "perf top --stdio" handle EOF from stdin correctly.
>     There is one getc() that does not handle EOF explicitly, since its re=
turn
>     value is checked against a list of known characters, and the main loo=
p in
>     display_thread() will handle the EOF on the next iteration.
>=20
>   02: perf kvm: Allow running without stdin
>     Make "perf kvm --stdio" handle EOF from stdin correctly.
>=20
>   03: perf kvm: Use evlist layer api when possible
>     This is a simple fix for a needless layering violation.
>=20
> Igor Lubashev (3):
>   perf top: Allow running without stdin
>   perf kvm: Allow running without stdin
>   perf kvm: Use evlist layer api when possible

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

>=20
>  tools/perf/builtin-kvm.c | 35 +++++++++++++++++++++--------------
>  tools/perf/builtin-top.c | 10 ++++++++--
>  2 files changed, 29 insertions(+), 16 deletions(-)
>=20
> --=20
> 2.7.4
>=20

