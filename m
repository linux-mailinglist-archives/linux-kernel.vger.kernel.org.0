Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44DF0156ACA
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Feb 2020 15:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgBIOBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Feb 2020 09:01:10 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38439 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727631AbgBIOBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 09:01:09 -0500
Received: by mail-lj1-f195.google.com with SMTP id w1so4156654ljh.5
        for <linux-kernel@vger.kernel.org>; Sun, 09 Feb 2020 06:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yBV6mzetXo3A4qYgtrGt4SU1OjOj6fpvSp1Lfl/49sY=;
        b=g0EAMd9/AHvsZaIzLqCXtSCUXr6wycOBoASYs8qbgtnuoK/APjRM+DrSLjvMnZcEdG
         HwExCPaje+vkWVpjGA1/8ckP8uvK3BezH1f15Q5SSHIWxaQORf0j7R5YXeYJ6PzSOW0g
         1ZW9SbyXn90RIXwB/mRYLrQZX1/rZuaX6dYI0WvnrSLPiGq9/t8Kz/9IotyCOs19hSva
         W5KqJgNQMcrmnEHlcz10wa2/2hInfQIruv7MZFRRmjYH4kYx+tmX5Vwn/D205Lhh/lmz
         wKnt0mJnex7eU7c4Jh8MskiF2ZpL10IiOzubdbCnq9N04wr3mGjl1wyjpYik8CRe0cfy
         bVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yBV6mzetXo3A4qYgtrGt4SU1OjOj6fpvSp1Lfl/49sY=;
        b=iu0MrVdvqxHxB+yr2jNEpKVhCtrDyGTU+a/YvZjOWeiPg8rUxXnCj4pCQ6PqUzOFc1
         DQuBRtdsqGTuu1ribUl+k2Z6mCDPz75Nr9GmGy9lk/zLRabSRqKOmIRn4l45qiCvxadv
         v7h8b+UzsEhoDlecGDPa8emMzvcfAlPn/Nckml7lntNFG89YFbxQ/z5pO6T6ZrAc1Cwv
         MuI30gsx0LWHdV51MZ/HOg91Qp8suoSBcqbgZlWcZud6OdDPysZYaVnpAZff5Fzo2om6
         dIRFqXFuzVedZkRTvbrCAhg27+bLQIeNj7i1TPlIdoa1nAoUkPwQMPxL1OoQ9GFzjqkx
         PGjw==
X-Gm-Message-State: APjAAAWkjApG7U85hZSuU+QMvHpSmDzQzvceAK/ALkRc+vH98CjvAKtn
        TUU0lZprvd2SnJwQyPeWGVu1XdXt
X-Google-Smtp-Source: APXvYqxppcv8z64bCEoaE3gjKBkjRRe4eghoJuncVhQrDkEoCljQYTrnL2TXLV/1O+op88hy+WsXJA==
X-Received: by 2002:a2e:b0e3:: with SMTP id h3mr5019015ljl.56.1581256866089;
        Sun, 09 Feb 2020 06:01:06 -0800 (PST)
Received: from pc-sasha.localdomain ([146.120.244.3])
        by smtp.gmail.com with ESMTPSA id d24sm3892165lfl.58.2020.02.09.06.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 06:01:05 -0800 (PST)
From:   Alexander Kapshuk <alexander.kapshuk@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, masahiroy@kernel.org,
        alexander.kapshuk@gmail.com
Subject: [PATCH] ver_linux: Query ld cache for versions of libc/libcpp run-time
Date:   Sun,  9 Feb 2020 16:00:57 +0200
Message-Id: <20200209140057.20181-1-alexander.kapshuk@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Query ld cache for versions of both libc and libcpp run-time, instead
of querying /proc/self/maps for libc run-time, and ld cache for libcpp
run-time, thus reducing code size and complexity.

Signed-off-by: Alexander Kapshuk <alexander.kapshuk@gmail.com>
---
 scripts/ver_linux | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/scripts/ver_linux b/scripts/ver_linux
index 85005d6b7f10..0968a3070eff 100755
--- a/scripts/ver_linux
+++ b/scripts/ver_linux
@@ -14,6 +14,8 @@ BEGIN {
 	printf("\n")

 	vernum = "[0-9]+([.]?[0-9]+)+"
+	libc = "libc[.]so[.][0-9]+$"
+	libcpp = "(libg|stdc)[+]+[.]so[.][0-9]+$"

 	printversion("GNU C", version("gcc -dumpversion"))
 	printversion("GNU Make", version("make --version"))
@@ -35,26 +37,14 @@ BEGIN {
 	printversion("Bison", version("bison --version"))
 	printversion("Flex", version("flex --version"))

-	while (getline <"/proc/self/maps" > 0) {
-		if (/libc.*\.so$/) {
-			n = split($0, procmaps, "/")
-			if (match(procmaps[n], vernum)) {
-				ver = substr(procmaps[n], RSTART, RLENGTH)
-				printversion("Linux C Library", ver)
-				break
-			}
-		}
+	while ("ldconfig -p 2>/dev/null" | getline > 0) {
+		if ($NF ~ libc && !seen[ver = version("readlink " $NF)]++)
+			printversion("Linux C Library", ver)
+		else if ($NF ~ libcpp && !seen[ver = version("readlink " $NF)]++)
+			printversion("Linux C++ Library", ver)
 	}

 	printversion("Dynamic linker (ldd)", version("ldd --version"))
-
-	while ("ldconfig -p 2>/dev/null" | getline > 0) {
-		if (/(libg|stdc)[+]+\.so/) {
-			libcpp = $NF
-			break
-		}
-	}
-	printversion("Linux C++ Library", version("readlink " libcpp))
 	printversion("Procps", version("ps --version"))
 	printversion("Net-tools", version("ifconfig --version"))
 	printversion("Kbd", version("loadkeys -V"))
--
2.25.0

