Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDEB1298A4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Dec 2019 17:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfLWQYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Dec 2019 11:24:00 -0500
Received: from smtp.inetstar.ru ([5.188.112.44]:38425 "EHLO smtp.inetstar.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726744AbfLWQYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 11:24:00 -0500
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Dec 2019 11:23:22 EST
Received: from [10.0.0.2] ([193.107.193.43])
  (AUTH: LOGIN work2017, SSL: TLS1.2,128bits,ECDHE_RSA_AES_128_GCM_SHA256)
  by smtp.inetstar.ru with ESMTPSA; Mon, 23 Dec 2019 19:23:58 +0300
  id 00000000009CDC5D.000000005E00EA1E.0000039B
From:   Sergey Kamenev <nilfs19@inetstar.ru>
Subject: New utility for NILFS2 partition
To:     linux-kernel@vger.kernel.org
Message-ID: <13ef2a41-9faa-fc6f-9b42-0bb48e6f591c@inetstar.ru>
Date:   Mon, 23 Dec 2019 19:23:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks!

I wrote utility for NILFS2 partition:

n2u

Repository: https://github.com/sukamenev/nilfs2_tools

She's working like "svn" command.

n2u can display the change history of a specific file / directory:

***************
n2u log filename
***************


The output is something like this:

    CHECKPOINT DATE            TIME         TYPE SIZE MODE
          1787552 2019-11-24 22:08:00 first 7079 cp
          1792659 2019-11-25 23:09:05 changed 7081 cp

It works quite quickly for the chosen implementation method: it searches for differences between files using the bisection method, quickly mounting and comparing the file / directory in different images.

You can specify a range of checkpoints using the -cp key CP1: CP2 or -cp {YEAR-MM-DD}: {YEAR-MM-DD}.

You can also see the difference between the checkpoints for a specific file or directory:

************************
n2u diff -r cp1: cp2 filename
************************

You can display the entire chronology of changes: all the differences between the checkpoints of a specific file / directory:

****************************
n2u blame [-r cp1: cp2] filename
****************************

The date range in this command is also supported.

Happy using!
Sergey Kamenev


