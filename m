Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63FA74F3E2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2019 07:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbfFVFgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jun 2019 01:36:20 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:38388 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfFVFgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 01:36:20 -0400
Received: by mail-lf1-f54.google.com with SMTP id b11so6492173lfa.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 22:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=acDGavsv+ifpDNzWCcEhjWjA5mBlJO3plfymnjZRfNs=;
        b=dS5T3+7C4pF3gau9qTu/iefZDi1XDNRzah4/GgUuE//TX37Nuo4NA+ux/SDCemgRdv
         OEXVvYEWSbtntmd85CyF2jE/sG2nJ7QNU9zCy9FWV7YaJnsboe8m46r5/JENLynhdtVw
         rVWwqWw9rWJCe75ubH1RRODEbCl+uM2asliTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=acDGavsv+ifpDNzWCcEhjWjA5mBlJO3plfymnjZRfNs=;
        b=ih46679fqre1qeJBb8eNafABYr8XxS5gqpZW3j+c7fC+fc64qvESHy5Zud9WGojMcX
         hdzZ4xdFQiMNEBwLKUK24qnxyr0No/QQaorxEf2ojz2AAUKgbSF4KH6SDqojMJMT0dnd
         opHh8twioz06jKPh/2SmriZ25MMugV1YBZOP8oU6SFTBOOwb9a4+BAtQWLbnUOpB+3NY
         VACnnUe33QwAvpqQXG7fdLmkWw39GJO/uqnmHdp61nzrWFZcj/BnDPxvDto0FojM6x2j
         Mdxqw3Kqx208yRThiPdFsRAOkeeR74sN3ALBlDUEYO6oFgjnlrEgfVzQJnrIjyMhD+lN
         EcQQ==
X-Gm-Message-State: APjAAAXsSmV+8DDQ4SnwVLjN/tQs4i3rkyJL5lOwILEI6AQ8xTINzYvK
        VwMUqbxF5vQotxlJRmYNZD5LyBehQC4=
X-Google-Smtp-Source: APXvYqy/t5BhbVe2+qi2JUuD25+9Dv3SjgriMKJpGZ9Qy0E7pc2WRlNfOVk1xVJyUoHDN+RvpR3dgA==
X-Received: by 2002:a05:6512:15a:: with SMTP id m26mr26447581lfo.71.1561181777822;
        Fri, 21 Jun 2019 22:36:17 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id z30sm721549lfj.63.2019.06.21.22.36.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 22:36:17 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id s21so7795855lji.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 22:36:16 -0700 (PDT)
X-Received: by 2002:a2e:9bc6:: with SMTP id w6mr5685402ljj.156.1561181776658;
 Fri, 21 Jun 2019 22:36:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190621.212137.1249209897243384684.davem@davemloft.net> <156118140484.25946.9601116477028790363.pr-tracker-bot@kernel.org>
In-Reply-To: <156118140484.25946.9601116477028790363.pr-tracker-bot@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 21 Jun 2019 22:36:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=whArwYU0KwEps4A6oRniRJ-B8K6VFX7gF=YGuFFaxDxqA@mail.gmail.com>
Message-ID: <CAHk-=whArwYU0KwEps4A6oRniRJ-B8K6VFX7gF=YGuFFaxDxqA@mail.gmail.com>
Subject: Re: [GIT] Networking
To:     pr-tracker-bot@kernel.org
Cc:     David Miller <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 10:30 PM <pr-tracker-bot@kernel.org> wrote:
>
> The pull request you sent on Fri, 21 Jun 2019 21:21:37 -0400 (EDT):
>
> > (unable to parse the git remote)

This "unable to parse the git remote" is apparently because the pull
request had an extraneous ':' in the remote description

  git://git.kernel.org:/pub/scm/linux/kernel/git/davem/net.git
                     ^^^

which seems to have confused the pr-tracker-bot.

               Linus
