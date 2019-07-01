Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCC23A484
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2019 11:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbfFIJfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jun 2019 05:35:09 -0400
Received: from www74.your-server.de ([213.133.104.74]:36902 "EHLO
        www74.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbfFIJfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 05:35:09 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www74.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <klaus.kusche@computerix.info>)
        id 1hZuEB-0002K7-NN; Sun, 09 Jun 2019 11:35:03 +0200
Received: from [95.91.111.137] (helo=[192.168.178.20])
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <klaus.kusche@computerix.info>)
        id 1hZuEB-000DrE-GD; Sun, 09 Jun 2019 11:35:03 +0200
From:   Klaus Kusche <klaus.kusche@computerix.info>
Subject: Re: [PATCH] x86/build: Move _etext to actual end of .text
To:     keescook@chromium.org, johannes.hirte@datenkhaos.de
Cc:     bp@suse.de, samitolvanen@google.com, linux-kernel@vger.kernel.org
Message-ID: <502d5b36-e0d0-ffcc-5dd4-35db9d033561@computerix.info>
Date:   Sun, 9 Jun 2019 11:35:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: klaus.kusche@computerix.info
X-Virus-Scanned: Clear (ClamAV 0.100.3/25475/Sun Jun  9 09:57:31 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

Same problem for linux 5.1.7: 
Kernel building fails with the same relocation error.

5.1.5 does not have the problem, builds fine for me.

Is there anything I can do to investigate the problem?


-- 
Prof. Dr. Klaus Kusche
Private address: Rosenberg 41, 07546 Gera, Germany
+49 365 20413058 klaus.kusche@computerix.info https://www.computerix.info
Office address: DHGE Gera, Weg der Freundschaft 4, 07546 Gera, Germany
+49 365 4341 306 klaus.kusche@dhge.de https://www.dhge.de
