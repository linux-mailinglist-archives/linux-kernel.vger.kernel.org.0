Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 546C51378B9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 22:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbgAJVwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 16:52:37 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43080 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbgAJVwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 16:52:36 -0500
Received: by mail-qt1-f195.google.com with SMTP id d18so3321888qtj.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 13:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cCm21HgtSk/IixhjEJUXB/t3b7AfTMGFi5/CTPzapCE=;
        b=JvvJDCanmRwq86qoJL1uI9SnVwSmLH76cLHJMoJ2njCPMjMm3UCDC5EabaIAgbxK8c
         6i1to0zg44D0LE8pUv7cy0p2rYyrGSRA6Tn+bbJF0rKirCo3b7G7DPtvQAL0e1QKAEsk
         CxIBO0Pt3ouQM8lNg2OHbUpeUDTzNMVv3e33p/jwTWagClNQvb6m98yKJkEbGxW7btP+
         nPI/y4mm19BXdWAq0/AFQw4it/qUhGZFO6tVXrMZKtVAmMQOw9v4YtaR7wNmoAzZAbEd
         +OvylFI2v0kwvGOI4ORr4ewMmusEAnviTBuTROs0lpsxplmybgEoKCks+hgXjTUtbRtG
         JL5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=cCm21HgtSk/IixhjEJUXB/t3b7AfTMGFi5/CTPzapCE=;
        b=JSRf4W+lalAFH98ARdtDRu7p+pz8Vd36K+pdNb1UJNGkkZ67YXag2gqpFESOVgcDi0
         thnZXzP+8qi/CElwWDgIaLPbq4dmEavxvOF56Wbea3enTHxcxfXjcBuJtMQqbk4lgA3L
         XhwQtRv4ZemdLQF5lDtZ9irlSWVguNGYKyvQcHsgl63l1hlDnHl8ipCSwru+SuqxTb0Q
         DGMKyDEuHfjlJAIkBvkvD1zRRLNy/gcyS1+qZARo7lwb25XkL4ASfXoNRqKI5q5SqGpU
         dULdMqh2FkKm8biUI3IG4unDI4hsbJerII+myXOxUOoD+8lfc+DnaZsPZCE58z10nSt7
         4jsA==
X-Gm-Message-State: APjAAAVIlxqmldR8OXT+Yjhi/rgllKyf/kMtFgD+SWf3DXfjJy/FSqQd
        xSr4ajNfN9DSYFlTW+JBBXs=
X-Google-Smtp-Source: APXvYqy82Fc9nw2RyHFilGXBhexfTlKrz6N+JQKA6fL5pXouZtM21LsjcSqQdiLLSIDP/NJNG8R4Ig==
X-Received: by 2002:ac8:7097:: with SMTP id y23mr4563007qto.114.1578693155543;
        Fri, 10 Jan 2020 13:52:35 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id c6sm1431901qka.111.2020.01.10.13.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 13:52:35 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 10 Jan 2020 16:52:33 -0500
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>
Subject: Re: [PATCH v2] x86/tools/relocs: Add _etext and
 __end_of_kernel_reserve to S_REL
Message-ID: <20200110215233.GA2164804@rani.riverdale.lan>
References: <20200110205028.GA2012059@rani.riverdale.lan>
 <20200110215005.2164353-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200110215005.2164353-1-nivedita@alum.mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 04:50:05PM -0500, Arvind Sankar wrote:
> Prior to binutiles-2.23, ld treats the location counter as absolute if
                  ^ Please fix this typo before merging (thanks)
