Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D98A170783
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 19:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbfGVRi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 13:38:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:45264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728710AbfGVRi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:38:56 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B42D21901;
        Mon, 22 Jul 2019 17:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563817135;
        bh=UgVydyRS3CfKa+Xmlw+o8J0uULffuzL++M23zJDPi2c=;
        h=From:To:Cc:Subject:Date:From;
        b=lTb9ODpvGK1mg97VGBQy3prlEmZuZiLU0FFvJWkXMqnF5s7VAgNnF4QVtnQGvAiZM
         ugqRnixVNr1SG6x10yVVXyG/wkPr3mlJZSLwlRdRaYwtZuXICG1AI4bayRC814bgH/
         HCGkNi25wg04F6LVItZPmgYVFVXLNSK+ApDoerDI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Denis Bakhvalov <denis.bakhvalov@intel.com>,
        Numfor Mbiziwo-Tiapo <nums@google.com>
Subject: [GIT PULL] perf/core improvements and fixes
Date:   Mon, 22 Jul 2019 14:38:02 -0300
Message-Id: <20190722173839.22898-1-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

	Please consider pulling,

Best regards,

- Arnaldo

