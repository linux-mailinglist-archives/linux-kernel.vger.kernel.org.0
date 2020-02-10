Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2B7157D73
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 15:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbgBJOcc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Feb 2020 09:32:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32599 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728193AbgBJOcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 09:32:31 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-iKWqynIAPNiugqxP5_D2Fg-1; Mon, 10 Feb 2020 09:32:23 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7232D1084442;
        Mon, 10 Feb 2020 14:32:21 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.43.17.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 85E2B60BF1;
        Mon, 10 Feb 2020 14:32:19 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH 0/4] perf tools: Fix kmap handling
Date:   Mon, 10 Feb 2020 15:32:14 +0100
Message-Id: <20200210143218.24948-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: iKWqynIAPNiugqxP5_D2Fg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
Ravi Bangoria reported crash in perf top due to wrong kmap
objects management, this patchset should fix that.

thanks,
jirka


---
Jiri Olsa (4):
      perf tools: Mark modules dsos with kernel type
      perf tools: Mark ksymbol dsos with kernel type
      perf tools: Fix map__clone for struct kmap
      perf tools: Move kmap::kmaps setup to maps__insert

 tools/perf/util/machine.c | 24 ++++++++++--------------
 tools/perf/util/map.c     | 17 ++++++++++++++++-
 2 files changed, 26 insertions(+), 15 deletions(-)

