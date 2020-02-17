Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8C2D161253
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 13:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbgBQMtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 07:49:02 -0500
Received: from sonic313-13.consmr.mail.bf2.yahoo.com ([74.6.133.123]:34789
        "EHLO sonic313-13.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726397AbgBQMtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 07:49:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1581943740; bh=YooljpITC31Cc9KXMfJzAPmr/1tCBEdX27fhfqn54Fs=; h=Date:From:Reply-To:Subject:References:From:Subject; b=rorp4BjsRFVoBIUpvfxi9S9rzDzK0EW77wAqZlMzBc+xfXg5JTdwllHVcvph7Dhg8nM+JRQppcHaNKc95UgopspEZ77uEfZYUYXjMKWhfTBN5CR3itz8X8Tm3qjenM+qCq/OiJVYzRm/uEw5xHMWo+x3dX8bOiDAO3MRLtCXdHUCjAGA/4UgYBVsvgHDBEzfzM98dM5zMTGox4fQq6BKqX3bjjeHiVRhlkktDR3UnKgYkOeoieKlnHpkJj7svgFefWh35Pm2bB4PuZl4kjINLJTP6BJ/pTxjec7ZrZ1vMxw3PaTO/fvH8ZsztfqU2DbVHxXKJMQcAmDQiQtckmjIcQ==
X-YMail-OSG: 5d8OF18VM1m38N5lNlptYof4D9o5q85LSFgu4yehfEa9Ye_nJlJNRGqQ.l_rY9O
 eT0T6im4cNDWZvgGRNiDEQJBAbTG8R8aVwNsvLsFSaPXx2nEtq7FyXpm6QL0TS03RGcCNgcQ2nt_
 SJBf4OCrOgAJ7G3hNtg62zjG3bC.Pv3LBxSqDS2dUGlcN06irRK4xwgZfVNF5sFmmUY1Ct.ebaac
 8AX_9vgD0qv2I4KZmTqlyj4GpMAi.NLXp7CxxlRmKTeXWT6a9p0jLfGUW94a8OIMXJYk9nE5Aj7L
 V2klY7SaAMf1xSIJ0WTEgAGQc.iIZ_gUyTRsQPROdQl2gV_kHTpNFb2LeA4yjzwmHx1K1gKWRzBY
 1BjPhQsJBZWxSI8cDVas0mjSbvAiLxbKL_5pkcJECjHh.ZjqXIn47peT5EskbNwUtrEF0kpfTBW8
 Uk7L9AMbYKL9etIyRNo8C3317tuRGdtaxMFHXYXz2Zr75QTTv9QzHZfi1QO4jfh1AVGHereI_NLe
 IaYvC2ajMyi.l85nJPdj._u0qSDIAR3JNwRo4vQyFqeA5kErEPmepXn8wBo_7w61r1iWobbs1_8Y
 Hjodid2dpohHCC02LQKP4_qaZErdZFb_r5_eKVFNJXGXDXa4sOoOWLSV5SmGQOuadIoyLTeKFFon
 kKIbdxm0qeunop7waDtYw3GUo8vZqSW5V3LMaLRFfW517AsRZZSAYGALORhGzzYBXFcoioSiKYIJ
 eOD8c75eJ4DM80cjjK4uUaIScXqLYJRl3jpapIDO3xHud1zokaDvAHetdR1HSDAwzl3bZZLHoBhI
 WbPYhgBW_RvyJjeqBHHSqSxKrwBi4FPmelIDaPl_ddqQ4Ow8EtTcTH8c6NXvU_.MhsmQuAlaivHS
 aygJWGSCt775vqxWnwgmvtlwRhpy8ToTSSlLtImeIe1G9FD_I5rlMHtZpm1IKiwdc_adZGVn8En3
 XZlPdgp4om1U733IpWODlCw0ojpeNIWfqsAbGFWF9I4MQwHmWppiDo1Doh2_ga87YUmnkXX4eDch
 98L6LKfFDW7cjqH0jV4u6i6iVCtY_XvGUXLMNdd87MFPJ6nzt9_tO.jiItkhKiSHFC961QqIqnuF
 z6mKhitr_oVcB5rRt2oaZAkNd_wefHrmvZvTH7caO8boGwjcy32n2SkUOAsa5j3rYGl1e8VLIX0_
 bTXzIJaFR4pmZuMv.QyUYGmV68YI35BPgBZsRzn6y47EJnMZrgo30UUzVAjkY6Wv9SNz8c_SnxMV
 djbcxvfOM.8sEUEgV.HWzlvBMffO1nII0wbUXly3mq0c23F6oBuTB0WbqyYLaq7p5wvONCRVp_0I
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.bf2.yahoo.com with HTTP; Mon, 17 Feb 2020 12:49:00 +0000
Date:   Mon, 17 Feb 2020 12:48:59 +0000 (UTC)
From:   Lisa Williams <ah6149133@gmail.com>
Reply-To: lisawilliams00357@yahoo.com
Message-ID: <515526656.2861295.1581943739374@mail.yahoo.com>
Subject: Hello
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <515526656.2861295.1581943739374.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15199 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:72.0) Gecko/20100101 Firefox/72.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hi Dear,

I was just going through the Internet search when I found your email address, I want to make a new and special friend, so I decided to contact you to see how we can make it work out if we can. Please I wish you will have the desire with me so that we can get to know each other better and see what happens in future.

My name is Lisa Williams, I am an American, but presently I live in the UK, I will be glad to see your reply for us to know each other better to exchange pictures and details about us

Yours
Lisa
