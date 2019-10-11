Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08E44D3840
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 06:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbfJKEOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 00:14:42 -0400
Received: from mail.ibgc.u-bordeaux2.fr ([193.55.211.31]:44923 "EHLO
        mail.ibgc.cnrs.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfJKEOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 00:14:42 -0400
X-Greylist: delayed 514 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Oct 2019 00:14:41 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.ibgc.cnrs.fr (Postfix) with ESMTP id C7B2878D52;
        Fri, 11 Oct 2019 06:00:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ibgc.cnrs.fr;
        s=201802; t=1570766433;
        bh=YvjI0OCPxItosJJfF/jTV1O7ohvFGATF1BRJHLsVj4A=;
        h=Date:From:Reply-To:Subject:From;
        b=d0TZ6kcxFylB07vch5AMoKEGaFZ3womm+OvarTcrt+2kawW5rOlnLFhn8DWT+vUmN
         peQvIU4sQtzCpnqh6k5EuzIyJGrkVzd7YH5SEPPcqtJmSdCKzO0M37jKgqFZIPgcMn
         3De56bPS/l0z9IjX3T1G0vwyofW36r3HRqAMbbZr1M0l6QmhvAzCpM/K5dEA3t4G8Y
         lZ7euzGQ/5YFLCHlShgBn5FJITbtVdNEn18vm/aZ/50A1b1EgYzPSRxF31vQ51wIIz
         BQpyfyC5m5eGwIRRcIcq7snlT9+hph3aF7etS4+UWcMzLEDFRP+efNiOrU05umCeQ/
         mn2ANL5shG88A==
X-Virus-Scanned: 1
X-Spam-Flag: NO
X-Spam-Score: -0.406
X-Spam-Level: 
X-Spam-Status: No, score=-0.406 tagged_above=-999 required=6.3
        tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, DKIM_SIGNED=0.1,
        DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FILL_THIS_FORM=0.001,
        MISSING_HEADERS=1.021, REPLYTO_WITHOUT_TO_CC=1.552,
        T_FILL_THIS_FORM_LOAN=0.01, T_FILL_THIS_FORM_LONG=0.01] autolearn=no
Received: from mail.ibgc.cnrs.fr ([127.0.0.1])
        by localhost (mail.ibgc.u-bordeaux2.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AS9LxPCeX2Za; Fri, 11 Oct 2019 06:00:16 +0200 (CEST)
Received: from zimbra.ibgc.cnrs.fr (zimbra.ibgc.cnrs.fr [193.55.211.30])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.ibgc.cnrs.fr (Postfix) with ESMTPS id 5724E78A94;
        Fri, 11 Oct 2019 03:44:33 +0200 (CEST)
Authentication-Results: mail.ibgc.cnrs.fr; dkim=pass
        reason="2048-bit key; insecure key"
        header.d=ibgc.cnrs.fr header.i=@ibgc.cnrs.fr header.b=a9Fb3xto;
        dkim-adsp=pass; dkim-atps=neutral
Received: from localhost (localhost [127.0.0.1])
        by zimbra.ibgc.cnrs.fr (Postfix) with ESMTP id E91721020551;
        Fri, 11 Oct 2019 03:49:32 +0200 (CEST)
Received: from zimbra.ibgc.cnrs.fr ([127.0.0.1])
        by localhost (zimbra.ibgc.cnrs.fr [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id pyVOu0UoM3A7; Fri, 11 Oct 2019 03:49:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.ibgc.cnrs.fr (Postfix) with ESMTP id 7416F102052B;
        Fri, 11 Oct 2019 03:49:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra.ibgc.cnrs.fr 7416F102052B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibgc.cnrs.fr;
        s=BEDBAE1E-22D7-11E8-BA54-248A139D4009; t=1570758572;
        bh=YvjI0OCPxItosJJfF/jTV1O7ohvFGATF1BRJHLsVj4A=;
        h=Date:From:Message-ID:MIME-Version;
        b=a9Fb3xtoysHu4zBFN3U8NUckaJmnhvVf0hJ5muEnbOPyKdrOGJsXPDqr1ujGOLA+d
         PWn5FKy2YGZ2X6x7uwNAcodXqBr0M4ZuOZMrAbxXhtqvGSR3crjwj5I01tlETS+pxN
         w8EQf2K6mOFRqXqLjuGaiaeVXudvjHEl7N1aKQOvsoGjIjLbF3ub9dDThzF/XBpr+U
         2XacOPCH7vSu10wDoXdsmrKBJQOX455Bf5i/pLWchNzi4B1kLHbnMhLyL3OVGBfWfi
         HJlBZPxKnzYIkQSj3La6ZpSMRfp0a/RsaJNaR8w+fyHWjWkHkcd8CxX8hiQJpW1TEN
         BYKjxetIr5k+A==
X-Virus-Scanned: amavisd-new at zimbra.ibgc.cnrs.fr
Received: from zimbra.ibgc.cnrs.fr ([127.0.0.1])
        by localhost (zimbra.ibgc.cnrs.fr [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id t2Xc_x_loZKp; Fri, 11 Oct 2019 03:49:30 +0200 (CEST)
Received: from zimbra.ibgc.cnrs.fr (localhost [127.0.0.1])
        by zimbra.ibgc.cnrs.fr (Postfix) with ESMTP id 3F09610204E8;
        Fri, 11 Oct 2019 03:49:20 +0200 (CEST)
Date:   Fri, 11 Oct 2019 03:49:20 +0200 (CEST)
From:   UK INTERNATIONAL DRAW HEADQUARTERS 
        <jasmina.zivanovic@ibgc.cnrs.fr>
Reply-To: UK INTERNATIONAL DRAW HEADQUARTERS 
          <uknationallotto360@gmail.com>
Message-ID: <1496202944.2089536.1570758560051.JavaMail.zimbra@ibgc.cnrs.fr>
Subject: Good News
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.7.11_GA_3800 (zclient/8.7.11_GA_3800)
Thread-Index: 2Dog3yrq6gBu5t859kPFvYL+DoLz2A==
Thread-Topic: Good News
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Your email has won you &pound;1,500,000.00 Great British Pounds.

To file for your Claims,please Contact Claims Agent: Mr Garry White.
E-mail: ( uknationallotto360@gmail.com )


Provide the information below:
1.Full Names:.... 2.Address:.........
3.Sex and Age:............ 4.Country:.............
5.Occupation:.......... 6.Phone no:........
