Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 083C5B533B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 18:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbfIQQnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 12:43:05 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55877 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfIQQnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 12:43:04 -0400
Received: by mail-wm1-f65.google.com with SMTP id g207so4297590wmg.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 09:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=yhTmZINtjNfdp4gy1K5HLazPZjxpYm/RmtHx4P4J7gY=;
        b=PWVPVn3VE37rm5VJuvT6zs5SFlmQsxfQq9dzO5BDmtNCkSdrQmQ5XLD5ordLBKslRs
         w6es5BFxMvAh0cS4GPmw/RcKde/+Oa2GSgFyFAvWgdQGHFufgD0933kklrd4pS6wG+oM
         p0YsLEUWNfj9r2qq2VSoNGL3DIlJPGeiaIUTMqJ6bqmSZ1ogv48zXcqb31yLz0isn1JU
         FTLA7Zss8cGdmQCbCB5NXFB1ix3RHCbh94sZTsEGJ+arTlwQp14d9bwXoj4RzlBWq0nC
         Wv49g4fZsQzRgJsR/Qw2cdthpmjFhrMH7zQyDxeOmzN/YBdu8OS7I3KNLLjkfaCvBa2l
         li8A==
X-Gm-Message-State: APjAAAUDEj3ajtxCpQrzr2pQxtpqnefjSYv2wwl8csLY6Qc8qVGsqa01
        c8OZIgJMaSVs5ad4dpfE9oQ=
X-Google-Smtp-Source: APXvYqxo7+Dhbm2ARLzfR1YcZoqWrp4JTcUZckLYvieruU64IlfJhLMXkN1r2iECDr4iJFLWN5CcqQ==
X-Received: by 2002:a7b:c4c9:: with SMTP id g9mr4729974wmk.150.1568738582617;
        Tue, 17 Sep 2019 09:43:02 -0700 (PDT)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c092:200::1:b644])
        by smtp.gmail.com with ESMTPSA id e30sm4936977wra.48.2019.09.17.09.43.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2019 09:43:01 -0700 (PDT)
Date:   Tue, 17 Sep 2019 17:43:00 +0100
From:   Dennis Zhou <dennis@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] percpu changes for v5.4-rc1
Message-ID: <20190917164300.GA77280@dennisz-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This pull request has a couple updates to clean up the code with no
change in behavior.

Thanks,
Dennis

The following changes since commit 6fbc7275c7a9ba97877050335f290341a1fd8dbf:

  Linux 5.2-rc7 (2019-06-30 11:25:36 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-5.4

for you to fetch changes up to 14d3761245551bdfc516abd8214a9f76bfd51435:

  percpu: Use struct_size() helper (2019-09-04 13:40:49 -0700)

----------------------------------------------------------------
Christophe JAILLET (1):
      percpu: fix typo in pcpu_setup_first_chunk() comment

Gustavo A. R. Silva (1):
      percpu: Use struct_size() helper

Kefeng Wang (1):
      percpu: Make pcpu_setup_first_chunk() void function

 arch/ia64/mm/contig.c    |  5 +----
 arch/ia64/mm/discontig.c |  5 +----
 include/linux/percpu.h   |  2 +-
 mm/percpu.c              | 23 +++++++++--------------
 4 files changed, 12 insertions(+), 23 deletions(-)
