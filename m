Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E35063C10
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 21:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbfGITnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 15:43:31 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:52296 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726358AbfGITna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 15:43:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 3FDD98EE247;
        Tue,  9 Jul 2019 12:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1562701410;
        bh=hPYD4bTdBFS+CEAiXuozREJ/sQr+8Csj4u3v9sBOl5Q=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=doczlQu2zOx7D4gL80vcI3RWLK/K7o+vbLbpDMjm2lV30tY1r4JW+od6J3mkvUxKQ
         +5/uqgGqKJc1Oyuyg2bHd53+pU198wtVbIsBdbmLte7ektjCuf2ahjgPKWpOYsixge
         Qdo9ssdxUtlXAhT/3sRZhtuVdwNlklCEhgJcwH50=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BK1nIjpso9V5; Tue,  9 Jul 2019 12:43:29 -0700 (PDT)
Received: from jarvis.lan (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 568778EE15F;
        Tue,  9 Jul 2019 12:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1562701408;
        bh=hPYD4bTdBFS+CEAiXuozREJ/sQr+8Csj4u3v9sBOl5Q=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=PNauBWhF1AvBF7wWb9WFdO8qEg3ktS/NTkBycA62sZ8kShlfZ7QSuV+NH7Cf5OEb8
         s2v+NkXncuJXHKjxfbf4EQotLfPQMnFed5BdogLlPCjZ2rSYbUD9khvpIBZJLHmbIi
         JkGe+VSVF5lFWIigILPqwNvkyLJg1SlXfV4xuM5s=
Message-ID: <1562701406.3362.105.camel@HansenPartnership.com>
Subject: Re: [GIT PULL] first round of SCSI updates for the 5.2+ merge window
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Tue, 09 Jul 2019 12:43:26 -0700
In-Reply-To: <yq1lfx7c80r.fsf@oracle.com>
References: <1562699693.3362.93.camel@HansenPartnership.com>
         <yq1lfx7c80r.fsf@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-09 at 15:39 -0400, Martin K. Petersen wrote:
> James,
> 
> > This is mostly update of the usual drivers: qla2xxx, hpsa, lpfc,
> > ufs, mpt3sas, ibmvscsi, megaraid_sas, bnx2fc and hisi_sas as well
> > as the removal of the osst driver (I heard from Willem privately
> > that he would like the driver removed because all his test hardware
> > has failed).  Plus number of minor changes, spelling fixes and
> > other trivia.
> 
> Looks like you forgot to pull in the scatterlist topic branch.

Actually, I was planning a second pull request for that one.  I presume
you think it's ready to go?

James

