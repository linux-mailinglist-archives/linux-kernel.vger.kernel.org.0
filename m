Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B110124651
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 12:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfLRL7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 06:59:42 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:51494 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726591AbfLRL7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 06:59:39 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TlHBU8U_1576670372;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TlHBU8U_1576670372)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 18 Dec 2019 19:59:33 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Harry Wei <harryxiyou@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] docs/zh_CN: translate kernel enforcement statement
Date:   Wed, 18 Dec 2019 19:59:26 +0800
Message-Id: <1576670367-153661-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now we have the Chinese version of this statemment.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Harry Wei <harryxiyou@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 .../zh_CN/process/kernel-enforcement-statement.rst | 146 +++++++++++++++++++++
 1 file changed, 146 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/process/kernel-enforcement-statement.rst

diff --git a/Documentation/translations/zh_CN/process/kernel-enforcement-statement.rst b/Documentation/translations/zh_CN/process/kernel-enforcement-statement.rst
new file mode 100644
index 000000000000..4c71229bf2d8
--- /dev/null
+++ b/Documentation/translations/zh_CN/process/kernel-enforcement-statement.rst
@@ -0,0 +1,146 @@
+﻿.. _cn_process_statement_kernel:
+
+Linux 内核执行声明
+------------------
+
+作为Linux内核的开发人员，我们对如何使用我们的软件以及如何实施软件许可证有着
+浓厚的兴趣。遵守GPL-2.0的互惠共享义务对我们软件和社区的长期可持续性至关重要。
+
+虽然有权强制执行对我们社区的贡献中的单独版权权益，但我们有共同的利益，即确保
+个人强制执行行动的方式有利于我们的社区，不会对我们软件生态系统的健康和增长
+产生意外的负面影响。为了阻止无益的执法行动，我们同意代表我们自己和我们版权
+利益的任何继承人对Linux内核用户作出以下符合我们开发社区最大利益的承诺:
+
+    尽管有GPL-2.0的终止条款，我们同意，采用以下GPL-3.0条款作为我们许可证下的
+    附加许可，作为任何对许可证下权利的非防御性主张，这符合我们开发社区的最佳
+    利益。
+
+        但是，如果您停止所有违反本许可证的行为，则您从特定版权持有人处获得的
+        许可证将被恢复：（a）暂时恢复，除非版权持有人明确并最终终止您的许可证；
+        以及（b）永久恢复, 如果版权持有人未能在你终止违反后60天内以合理方式
+        通知您违反本许可证的行为，则永久恢复您的许可证。
+
+        此外，如果版权所有者以某种合理的方式通知您违反了本许可，这是您第一次
+        从该版权所有者处收到违反本许可的通知（对于任何作品），并且您在收到通知
+        后的30天内纠正违规行为。则您从特定版权所有者处获得的许可将永久恢复.
+
+我们提供这些保证的目的是鼓励更多地使用该软件。我们希望公司和个人使用、修改和
+分发此软件。我们希望以公开和透明的方式与用户合作，以消除我们对法规遵从性或强制
+执行的任何不确定性，这些不确定性可能会限制我们软件的采用。我们将法律行动视为
+最后手段，只有在其他社区努力未能解决这一问题时才采取行动。
+
+最后，一旦一个不合规问题得到解决，我们希望用户会感到欢迎，加入我们为之努力的
+这个项目。共同努力，我们会更强大。
+
+除了下面提到的以外，我们只为自己说话，而不是为今天、过去或将来可能为之工作的
+任何公司说话。
+
+  - Laura Abbott
+  - Bjorn Andersson (Linaro)
+  - Andrea Arcangeli
+  - Neil Armstrong
+  - Jens Axboe
+  - Pablo Neira Ayuso
+  - Khalid Aziz
+  - Ralf Baechle
+  - Felipe Balbi
+  - Arnd Bergmann
+  - Ard Biesheuvel
+  - Tim Bird
+  - Paolo Bonzini
+  - Christian Borntraeger
+  - Mark Brown (Linaro)
+  - Paul Burton
+  - Javier Martinez Canillas
+  - Rob Clark
+  - Kees Cook (Google)
+  - Jonathan Corbet
+  - Dennis Dalessandro
+  - Vivien Didelot (Savoir-faire Linux)
+  - Hans de Goede
+  - Mel Gorman (SUSE)
+  - Sven Eckelmann
+  - Alex Elder (Linaro)
+  - Fabio Estevam
+  - Larry Finger
+  - Bhumika Goyal
+  - Andy Gross
+  - Juergen Gross
+  - Shawn Guo
+  - Ulf Hansson
+  - Stephen Hemminger (Microsoft)
+  - Tejun Heo
+  - Rob Herring
+  - Masami Hiramatsu
+  - Michal Hocko
+  - Simon Horman
+  - Johan Hovold (Hovold Consulting AB)
+  - Christophe JAILLET
+  - Olof Johansson
+  - Lee Jones (Linaro)
+  - Heiner Kallweit
+  - Srinivas Kandagatla
+  - Jan Kara
+  - Shuah Khan (Samsung)
+  - David Kershner
+  - Jaegeuk Kim
+  - Namhyung Kim
+  - Colin Ian King
+  - Jeff Kirsher
+  - Greg Kroah-Hartman (Linux Foundation)
+  - Christian König
+  - Vinod Koul
+  - Krzysztof Kozlowski
+  - Viresh Kumar
+  - Aneesh Kumar K.V
+  - Julia Lawall
+  - Doug Ledford
+  - Chuck Lever (Oracle)
+  - Daniel Lezcano
+  - Shaohua Li
+  - Xin Long
+  - Tony Luck
+  - Catalin Marinas (Arm Ltd)
+  - Mike Marshall
+  - Chris Mason
+  - Paul E. McKenney
+  - Arnaldo Carvalho de Melo
+  - David S. Miller
+  - Ingo Molnar
+  - Kuninori Morimoto
+  - Trond Myklebust
+  - Martin K. Petersen (Oracle)
+  - Borislav Petkov
+  - Jiri Pirko
+  - Josh Poimboeuf
+  - Sebastian Reichel (Collabora)
+  - Guenter Roeck
+  - Joerg Roedel
+  - Leon Romanovsky
+  - Steven Rostedt (VMware)
+  - Frank Rowand
+  - Ivan Safonov
+  - Anna Schumaker
+  - Jes Sorensen
+  - K.Y. Srinivasan
+  - David Sterba (SUSE)
+  - Heiko Stuebner
+  - Jiri Kosina (SUSE)
+  - Willy Tarreau
+  - Dmitry Torokhov
+  - Linus Torvalds
+  - Thierry Reding
+  - Rik van Riel
+  - Luis R. Rodriguez
+  - Geert Uytterhoeven (Glider bvba)
+  - Eduardo Valentin (Amazon.com)
+  - Daniel Vetter
+  - Linus Walleij
+  - Richard Weinberger
+  - Dan Williams
+  - Rafael J. Wysocki
+  - Arvind Yadav
+  - Masahiro Yamada
+  - Wei Yongjun
+  - Lv Zheng
+  - Marc Zyngier (Arm Ltd)
-- 
1.8.3.1

