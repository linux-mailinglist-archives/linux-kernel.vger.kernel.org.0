Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C67B818ABF6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 06:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgCSFF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 01:05:59 -0400
Received: from st43p00im-ztfb10063301.me.com ([17.58.63.179]:47493 "EHLO
        st43p00im-ztfb10063301.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725812AbgCSFF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 01:05:58 -0400
X-Greylist: delayed 442 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Mar 2020 01:05:58 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1584593915;
        bh=1voWJN/czyHvqib1bVzqOXLQJutRaTddvJN9MMtGQHk=;
        h=Content-Type:From:Date:Subject:Message-Id:To;
        b=SO0v9oV4OMf+3cZ8IwrSnG6AI8Qk/qSH6vXySPHVxgkOChTBaGuPyUwqN8UI8bHgu
         mv2+w19iPxZgefsKXATTXgRv2vHvJoCUX7RcYkTs4hpMoRj4pf6mixoHmuIBwpbHeD
         iZFPIfKnAl9NuKDQ9BIZEbSuUhKge18gpAl8Soe0WVudy9pEpEBsAXf16CFM1NUcSk
         efnB1I7g+ul3Kj22BXGvkabLbgAFaBu3k65rYLYsjUMD1rpWXp8rBcEFYOf16Fb7Tv
         y/FNgIGq+sDVwIT5j7b/Xp0MrX80gd7/Gsg/Drxu7LhhJl6s0ZH2ZxUr1RmGzdt+hZ
         gzJU5LxeKwjOA==
Received: from [192.168.86.44] (cpe-107-10-57-205.neo.res.rr.com [107.10.57.205])
        by st43p00im-ztfb10063301.me.com (Postfix) with ESMTPSA id 0B70DA4065F;
        Thu, 19 Mar 2020 04:58:35 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   David English <ohiogeek@icloud.com>
Mime-Version: 1.0 (1.0)
Date:   Thu, 19 Mar 2020 00:58:34 -0400
Subject: Re: [PATCH v8 11/12] x86/retpoline/irq32: Convert assembler indirect jumps
Message-Id: <E76EFD74-2125-4E12-BA34-C36B69A08B8A@icloud.com>
Cc:     ak@linux.intel.com, dave.hansen@intel.com,
        gnomes@lxorguk.ukuu.org.uk, gregkh@linux-foundation.org,
        jikos@kernel.org, jpoimboe@redhat.com, keescook@google.com,
        linux-kernel@vger.kernel.org, luto@amacapital.net,
        peterz@infradead.org, pjt@google.com, riel@redhat.com,
        tglx@linutronix.de, thomas.lendacky@amd.com,
        tim.c.chen@linux.intel.com, torvalds@linux-foundation.org,
        x86@kernel.org
To:     dwmw@amazon.co.uk
X-Mailer: iPhone Mail (17D50)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2020-03-18_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=415 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-2003190022
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Please delete my provate information 
Sent from my iPhone
