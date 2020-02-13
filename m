Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 523DE15B893
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 05:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbgBME1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 23:27:24 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39802 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729477AbgBME1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 23:27:24 -0500
Received: by mail-lj1-f195.google.com with SMTP id o15so4966778ljg.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 20:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WoWIdzlw5trWCHZhfGRFIJxKt3FDsBXEyWAtdabN8sY=;
        b=qW9Ox3i586wFUDJjEKf1igpjkBFT9KmVETivNwpNoX6LIcKRXXMHU91u7XLRhOYbbp
         LodlrLUCO2v4tZ89vrIZe/N/VVKpJQ/gW0T5tEciAHeB7AR1f2dQtJQuwCDIHtlKgu3Y
         wJATjRkkJW/7FQRJ0skd2ZgSmrKeEJVgNRWb3+RkxOFRmsWoQyHVHfgYuiWauxSHnoDa
         BWe+2SNTY/4t60SktQoG6gkTmdnVZUqBMfu9c12w9oU4EYiftk5h9cgXENX5R2px2LW+
         JGrDv//92jUiNIzRwiEgxxVpzLNRrI9zfTDGKB6pSsxi8pGO6cHdQUJ30OAlsPdFyKV7
         G8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WoWIdzlw5trWCHZhfGRFIJxKt3FDsBXEyWAtdabN8sY=;
        b=X/gt1FPLA3Hxf2XzyrJVWUZrf0vEqYVs4BnUfLq+rw1jgx2OV6bu2R/h7Jg+67eTXn
         OWQDjh+jiAZXNdC6SGuzpqKCVSyxFssScJoptty5bMdXG7YNATiksWlSQ8Hn7kIX1gJQ
         d53RDE8x6UNbZNt2Gcl+O9sufpICAotB7/WqF9ScY3VgG8kTnmB/5sg4a21j2b8xXyEw
         tZbsvgTeNEMJVNmcaCQ+dHTb5CxahtlmRtwZyhkbnqiph3C8CamGgFW5Ot/bnqyUdbJS
         jjRhCZ/+A8zha1fVFT0hR1gzTyo4nCRyA3ezHjjUfTrcU/naPnMOWkXTziI5ESMNTqRo
         Nvig==
X-Gm-Message-State: APjAAAUsfWRGseZhkeD/xnADcjkuKdP1jT+FmiZM1uSj8M+yCOZr2ssT
        2o4t8Mu4wouSFC/sYA/qQoV24bt9qoZHMHJKFnSa
X-Google-Smtp-Source: APXvYqyzneK3Mh2NLoEsaT1/JjMUbQOig171deGCoZKgu7zDdTLRoj0V5HrtUB5qU+pJYQdNEZETzL6VKA5EW7VCtDE=
X-Received: by 2002:a2e:7812:: with SMTP id t18mr10268655ljc.289.1581568040531;
 Wed, 12 Feb 2020 20:27:20 -0800 (PST)
MIME-Version: 1.0
References: <20200212222922.5dfa9f36@oasis.local.home> <20200213042331.157606-1-zzyiwei@google.com>
In-Reply-To: <20200213042331.157606-1-zzyiwei@google.com>
From:   Yiwei Zhang <zzyiwei@google.com>
Date:   Wed, 12 Feb 2020 20:27:09 -0800
Message-ID: <CAKT=dDmBbrupMviewQwnzqw4ijcXDBw+AF=BYJ_3p_wZOyuQsw@mail.gmail.com>
Subject: Re: [PATCH v3] gpu/trace: add gpu memory tracepoints
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     Prahlad Kilambi <prahladk@google.com>,
        Joel Fernandes <joelaf@google.com>,
        android-kernel <android-kernel@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

Just update a v3 here with the gpu/trace: included in the subject
line. You might have received a spam v3 previously, which I forgot to
include linux-kernel@vger.kernel.org...sorry for the confusion.

Best,
Yiwei
