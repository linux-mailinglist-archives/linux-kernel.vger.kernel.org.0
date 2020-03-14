Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9EC18584B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Mar 2020 03:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbgCOCC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Mar 2020 22:02:27 -0400
Received: from smtprelay0001.hostedemail.com ([216.40.44.1]:38378 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726550AbgCOCC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 22:02:27 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave01.hostedemail.com (Postfix) with ESMTP id 4185A1803D435;
        Sat, 14 Mar 2020 21:15:46 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 0A5D1180286F5;
        Sat, 14 Mar 2020 21:15:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:152:355:379:800:960:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1437:1515:1516:1518:1534:1544:1593:1594:1711:1730:1747:1777:1792:1801:2376:2393:2559:2562:2693:2827:3138:3139:3140:3141:3142:3355:3865:3866:3867:3868:3870:3872:3873:3874:4250:4321:4605:5007:6119:7903:7904:7974:10004:10848:11232:11657:11658:11783:11914:12043:12048:12295:12297:12346:12555:12986:13894:14181:14394:14659:14721:21067:21080:21627:21795:30034:30051:30054:30070,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: order55_4f4bcd68dbf2c
X-Filterd-Recvd-Size: 4799
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Sat, 14 Mar 2020 21:15:44 +0000 (UTC)
Message-ID: <7a2977ea9baacd1580ff80689f2c8f20d45b069d.camel@perches.com>
Subject: [PATCH] coding-style.rst: Add fallthrough as an emacs keyword
From:   Joe Perches <joe@perches.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 14 Mar 2020 14:13:59 -0700
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fallthrough was added as a pseudo-keyword by commit 294f69e662d1
("compiler_attributes.h: Add 'fallthrough' pseudo keyword for switch/case use")

Add fallthrough as a keyword to the example .emacs content
so emacs can colorize or highlight the uses.

Signed-off-by: Joe Perches <joe@perches.com>
---

I've no idea how to remove the infinite monkeys jibe from the chinese translation

 Documentation/process/coding-style.rst                    | 9 +++++----
 Documentation/translations/it_IT/process/coding-style.rst | 9 +++++----
 Documentation/translations/zh_CN/process/coding-style.rst | 5 ++++-
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
index acb2f1b..3260cd 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -577,9 +577,7 @@ item, explaining its use.
 That's OK, we all do.  You've probably been told by your long-time Unix
 user helper that ``GNU emacs`` automatically formats the C sources for
 you, and you've noticed that yes, it does do that, but the defaults it
-uses are less than desirable (in fact, they are worse than random
-typing - an infinite number of monkeys typing into GNU emacs would never
-make a good program).
+uses are less than desirable.
 
 So, you can either get rid of GNU emacs, or change it to use saner
 values.  To do the latter, you can stick the following in your .emacs file:
@@ -631,7 +629,10 @@ values.  To do the latter, you can stick the following in your .emacs file:
 
   (dir-locals-set-directory-class
    (expand-file-name "~/src/linux-trees")
-   'linux-kernel)
+   'linux-kernel
+   (font-lock-add-keywords 'c-mode
+			   '(("\\<\\(fallthrough\\)\\>" . font-lock-keyword-face)))
+  )
 
 This will make emacs go better with the kernel coding style for C
 files below ``~/src/linux-trees``.
diff --git a/Documentation/translations/it_IT/process/coding-style.rst b/Documentation/translations/it_IT/process/coding-style.rst
index 8725f2b..67364f 100644
--- a/Documentation/translations/it_IT/process/coding-style.rst
+++ b/Documentation/translations/it_IT/process/coding-style.rst
@@ -584,9 +584,7 @@ commento per spiegarne l'uso.
 Va bene, li facciamo tutti.  Probabilmente vi è stato detto dal vostro
 aiutante Unix di fiducia che ``GNU emacs`` formatta automaticamente il
 codice C per conto vostro, e avete notato che sì, in effetti lo fa, ma che
-i modi predefiniti non sono proprio allettanti (infatti, sono peggio che
-premere tasti a caso - un numero infinito di scimmie che scrivono in
-GNU emacs non faranno mai un buon programma).
+i modi predefiniti non sono proprio allettanti.
 
 Quindi, potete sbarazzarvi di GNU emacs, o riconfigurarlo con valori più
 sensati.  Per fare quest'ultima cosa, potete appiccicare il codice che
@@ -639,7 +637,10 @@ segue nel vostro file .emacs:
 
   (dir-locals-set-directory-class
    (expand-file-name "~/src/linux-trees")
-   'linux-kernel)
+   'linux-kernel
+   (font-lock-add-keywords 'c-mode
+			   '(("\\<\\(fallthrough\\)\\>" . font-lock-keyword-face)))
+  )
 
 Questo farà funzionare meglio emacs con lo stile del kernel per i file che
 si trovano nella cartella ``~/src/linux-trees``.
diff --git a/Documentation/translations/zh_CN/process/coding-style.rst b/Documentation/translations/zh_CN/process/coding-style.rst
index eae10bc..6c9443 100644
--- a/Documentation/translations/zh_CN/process/coding-style.rst
+++ b/Documentation/translations/zh_CN/process/coding-style.rst
@@ -558,7 +558,10 @@ Documentation/doc-guide/ 和 scripts/kernel-doc 以获得详细信息。
 
   (dir-locals-set-directory-class
    (expand-file-name "~/src/linux-trees")
-   'linux-kernel)
+   'linux-kernel
+   (font-lock-add-keywords 'c-mode
+			   '(("\\<\\(fallthrough\\)\\>" . font-lock-keyword-face)))
+  )
 
 这会让 emacs 在 ``~/src/linux-trees`` 下的 C 源文件获得更好的内核代码风格。
 


