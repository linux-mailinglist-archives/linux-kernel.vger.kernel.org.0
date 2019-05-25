Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A06B02A58E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2019 18:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfEYQ6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 May 2019 12:58:15 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42001 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbfEYQ6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 12:58:12 -0400
Received: by mail-pl1-f193.google.com with SMTP id go2so5390524plb.9
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 09:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OR3Uh1cJ8Y1n+6QAYb02IJsWUect/WZG9WpBebQdk68=;
        b=g3u8BE8Lva4Y9OUxdjjAUNev8EVPv54yOh4+UePGhbW22qFyoHy7Q/m58nEZVJ4vBt
         c858McMgmH/Q8ADAR1Bv39n5xg+cePiAdNSkXnPiU9BHEhOLQsK8k7q2ffChaZN3Dz6L
         cqKZgDT5scqE4naRNCR5qWmydlz7fUoAGQRVcA+xsugqcLUj55W5Mhobe0fnhoSs6WhZ
         YYHM4NQDoQI+rplLGlu1+zQFFrMESy0yo3dtcsd9MCoAVkiHGYn2uNy6at+J9Zn9++aG
         Cnrsu0oD5HZfuwkKY8EgDYPQUmlGgejlQKnrQfe3gmd7ZpSx/J0GYIQKczMHBP1TSvNa
         KzdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OR3Uh1cJ8Y1n+6QAYb02IJsWUect/WZG9WpBebQdk68=;
        b=SCLRwMsQL1QM04pHRcCiXinN3jg5f6GPgD6tGjmHuineRhqr1B1kah7jPAVvkMp00t
         fx0tqtcTuUEbo6CDZhbWrzn2Adfg83d2yNyBY+GhaT9SFI3GZLG+T0SOpEDTEU028wVu
         BiBlhqZiPdQRKWanGoGaDjB4Yp+6eYQLtvonHjrEFRIbaZ1Nl4ZkEtnfX7NW4QTfZOTc
         yX/lXBF+VfhoSZ71YjIVEwXAplKx3xvTuGVJ9e6jtXZugPoa1YKKZOPTOhaAvYV8Naow
         vD3MIvCDAkuFWXOznzQnmqAajMCSNYH4lYnirT6dw0QSKJxc8am3FNAiELYft2qm1M1f
         W9aw==
X-Gm-Message-State: APjAAAUeStV3TiDB5zI+scH40m2eeH2RPf05KzDQI+nmwzCw3JIKkCns
        A1JYPjUiY0Hq3m7TjB6j6ycgmHcp
X-Google-Smtp-Source: APXvYqzN7JNjfBlbCR56hjKlj+XlxRx6pBpTGp3rkR/8X2rbA7aPV3a5eOi28sxRexIZg+oOMQnzbw==
X-Received: by 2002:a17:902:b204:: with SMTP id t4mr62632794plr.285.1558803491930;
        Sat, 25 May 2019 09:58:11 -0700 (PDT)
Received: from tw-172-25-31-76.office.twttr.net ([8.25.197.24])
        by smtp.gmail.com with ESMTPSA id q142sm8787585pfc.27.2019.05.25.09.58.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 May 2019 09:58:11 -0700 (PDT)
From:   Cong Wang <xiyou.wangcong@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH 2/4] trace: let filter_assign_type() detect FILTER_PTR_STRING
Date:   Sat, 25 May 2019 09:58:00 -0700
Message-Id: <20190525165802.25944-3-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190525165802.25944-1-xiyou.wangcong@gmail.com>
References: <20190525165802.25944-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

filter_assign_type() could detect dynamic string and static
string, but not string pointers. Teach filter_assign_type()
to detect string pointers, and this will be needed by trace
event injection code.

BTW, trace event hist uses FILTER_PTR_STRING too.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 kernel/trace/trace_events_filter.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index d3e59312ef40..550e8a0d048a 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1080,6 +1080,9 @@ int filter_assign_type(const char *type)
 	if (strchr(type, '[') && strstr(type, "char"))
 		return FILTER_STATIC_STRING;
 
+	if (strcmp(type, "char *") == 0 || strcmp(type, "const char *") == 0)
+		return FILTER_PTR_STRING;
+
 	return FILTER_OTHER;
 }
 
-- 
2.21.0

