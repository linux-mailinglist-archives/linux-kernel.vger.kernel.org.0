Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC647534E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 17:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387996AbfGYP5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 11:57:50 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34303 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbfGYP5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 11:57:50 -0400
Received: by mail-qk1-f195.google.com with SMTP id t8so36813450qkt.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 08:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:message-id:user-agent:mime-version;
        bh=SPla4j9UdRCMl3oT+x1yXD7PU4HvdshXTJucOKF1pKw=;
        b=WO6CO2eEsVX56amwoXxnX6jynuaxAZM+Zv/iVCedoW/U6OS+gPcp8IB5KcFqiHEIag
         FOr9gZ7zG/q6wecsdlcYaRNb8+dVv3zw1ptgIwgBsXFR/FQmGK5kYo+2Z6+2RR2gRsML
         7O12GvF9lKk1epDu1dHz0wrQtJTPG3HOo1Qlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=SPla4j9UdRCMl3oT+x1yXD7PU4HvdshXTJucOKF1pKw=;
        b=qEX6SywKhLQapdU2++sk+PN+pb9naXSqCT7w4hM+eaS3XtHsJP9xnBi+ULNafjrfFB
         14hMZDzGY5YOQcTlfHmWGHwvBq7wInhZG7uonjFgP5teDyZzuS+aYmaoPWHMNjPR5hw0
         VHxz7g9xp6uzrOZW+fRUX0llD7KFqbbV1g2AQZKI7ZP4UcooCtTwhdQE3Iw2kJvlzkF9
         +7+W2PSvTx5cp85FdddWoxqpiFRmHvzhoGqlcecvD460/EsRmjx5PgjLD2ZPTK8gd4rB
         IeGpRRubxbthVsF2tGASksk45dlNRWpUFR5+JdRG6HK1k2cjh20PWGVWkEhlOL+TVtUC
         y7Pg==
X-Gm-Message-State: APjAAAU4UFGYgwsmbOm0+e/BcSHzJGMWutZ3Q0MsFrN6twNCAK+a2Q+i
        ust53q5iQgtyP7QQjmun0rYDMphwpUU=
X-Google-Smtp-Source: APXvYqyPo6jhgx/4hoKQx0SNm+A9Bbj7SDfO+YabgfS7YSYSoBfDWjsrBg3oH08ngG8fh8q5ofd6ZQ==
X-Received: by 2002:a37:c40b:: with SMTP id d11mr53808447qki.78.1564070268693;
        Thu, 25 Jul 2019 08:57:48 -0700 (PDT)
Received: from macbook-air (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id w80sm24043655qka.74.2019.07.25.08.57.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 08:57:47 -0700 (PDT)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Thu, 25 Jul 2019 11:57:43 -0400 (EDT)
X-X-Sender: vince@macbook-air
To:     linux-kernel@vger.kernel.org
cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [patch] perf.data documentation has wrong units for memory size
Message-ID: <alpine.DEB.2.21.1907251155500.22624@macbook-air>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The perf.data-file-format documentation incorrectly says the 
HEADER_TOTAL_MEM results are in bytes.  The results are in kilobytes
(perf reads the value from /proc/meminfo)

Signed-off-by: Vince Weaver <vincent.weaver@maine.edu>

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index 5f54feb19977..d030c87ed9f5 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -126,7 +126,7 @@ vendor,family,model,stepping. For example: GenuineIntel,6,69,1
 
 	HEADER_TOTAL_MEM = 10,
 
-An uint64_t with the total memory in bytes.
+An uint64_t with the total memory in kilobytes.
 
 	HEADER_CMDLINE = 11,
 
