Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7055A61329
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2019 00:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfGFWpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Jul 2019 18:45:13 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43148 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfGFWpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 18:45:12 -0400
Received: by mail-pf1-f196.google.com with SMTP id i189so5773258pfg.10
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2019 15:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=KZuwwpEDFFidTZvCB013aANFUOOg31tF9n5M77JSn6w=;
        b=L2olCuuAvGq0806TGK59wMZhuTO9EVAfk3ga/cDt+R/5EhMP0+heHReCNlnPQDSkGp
         zGOPzi9ERGBvpgjYMxEVfHRrpbbXjbg9Tumnson9Aj9d9S6tOlEMiXFMwzktp7ZoFa3j
         3V4SxfHzDv2eIU000+5AZUoa1Vtg/lRF68Rlt5ugGh4CRwA4IKmmpjhUDLoci2ZaePqX
         HSR3SKOK5gu0GgWUlM9Rx0PxavwGWVtiwv6Ta5AOjENY0n47KgVxkOLu73lQUOx9c9sL
         IpfijZ2PChnxS65QjOoFAk9wJ0S9i/zj+e2Oc8PK+C/M1rSSj52DmRST89qhWX1QIG1e
         nXpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=KZuwwpEDFFidTZvCB013aANFUOOg31tF9n5M77JSn6w=;
        b=Gzl2GEAI44ISchPYPsCeNqnHriindSd9b0Rvj1VYzjH+c/D4cyt1KrTzxC1Jwiab/1
         EgRx0Ks89bx4grUbYVffhQ3UI886B6+AFtobJGfi2fvpfzWpjFpHbYuI7Zv0Nb+O2cIA
         JOO24JQwyZF2lD+bamCzr0p3OAua9WkkpBekuci57JPunEfwFP5nqfEB7mX3G8l5eLtq
         CiGx77ESxE0wLza/qJhUdny3Fd4gaLYLorVOZCm3Ro0PHZQ0LGMVwBHTN/6pztRDBQ42
         uPRUPu/8iO8VFdwxyoz02REutS6d6amlHPjptChMh5GdyH4jlLUBQtYVKPoKpWINJb+P
         81JQ==
X-Gm-Message-State: APjAAAWlKNDpSNOWrAmTNCG0Ui8oE1fY7k3IgFR5R/vWSRnudGkAzTiG
        TQcQkUuSTdYnP5UF0nGEQOXG0g==
X-Google-Smtp-Source: APXvYqy99zQ1u6U2AvHd71woEPV1gm8EDjjXuQvomJnzfLlJWwx2tPqF1zsuElqnQVfiPN3ciDpYHg==
X-Received: by 2002:a17:90a:d3d4:: with SMTP id d20mr14263697pjw.28.1562453111723;
        Sat, 06 Jul 2019 15:45:11 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id n17sm13000168pfq.182.2019.07.06.15.45.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 06 Jul 2019 15:45:10 -0700 (PDT)
Date:   Sat, 6 Jul 2019 15:45:10 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Christopher Lameter <cl@linux.com>
cc:     Markus Elfring <Markus.Elfring@web.de>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mm/slab: One function call less in
 verify_redzone_free()
In-Reply-To: <0100016bc3579800-ee6cd00b-6f59-4d86-be0c-f63e2b137d18-000000@email.amazonses.com>
Message-ID: <alpine.DEB.2.21.1907061542480.103032@chino.kir.corp.google.com>
References: <c724416e-c8bc-6927-00c5-7a4c433c562f@web.de> <0100016bc3579800-ee6cd00b-6f59-4d86-be0c-f63e2b137d18-000000@email.amazonses.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jul 2019, Christopher Lameter wrote:

> On Fri, 5 Jul 2019, Markus Elfring wrote:
> 
> > Avoid an extra function call by using a ternary operator instead of
> > a conditional statement for a string literal selection.
> 
> Well. I thought the compiler does that on its own? And the tenary operator
> makes the code difficult to read.
> 

Right, and I don't understand the changelog: yes, there's one less 
function call in the source but functionally there's still a conditional; 
this isn't even optimizing DEBUG builds.
