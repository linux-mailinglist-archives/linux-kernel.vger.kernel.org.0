Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5F40C93FA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2019 00:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfJBWEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Oct 2019 18:04:11 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34115 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfJBWEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 18:04:11 -0400
Received: by mail-wm1-f67.google.com with SMTP id y135so5868299wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 15:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=mCFqTkVnKK1k9p/md9KIkY0flsD08/UGZyGSki1ovfI=;
        b=PSi4KKWIwGEg0MJFhjUVnAaK7P2oOlA8eK9uE29wmIAlvhqQWBwNNAKc1aa8K4SBvU
         b+RsDEVNLhpRuZ3sW6hNCZXt9GS9OsF69SfcPH0RLUXRJxfW8B7IRq6R+OEIAbjmeH2V
         Czr1ZOr7hZ7x2AsOBdSudk+3OdeE2mSyvvqjfRziAanMt/2pbl/bHEkvD9GryfBtJc+3
         nxCVgp4/Owhl7u0e8/Qp0bGpcMEB1Q3lN9Fj81Xk3wWpndL7eNNyXKXHZKFJjP6DqYkd
         xDPacvylm1To/jhyQjDNM7PQ2GUeL+YZ7iRQ6jcHYEUQtiW/PDVQyYWIPrS1DIVLnY6K
         a31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=mCFqTkVnKK1k9p/md9KIkY0flsD08/UGZyGSki1ovfI=;
        b=B/0mfWb49QOS704Ns1zBPHf/eyV2seWvs+hHzKVoqY2LEhpFjKa/zr2zIlcBMJVY7q
         jiXlhqgSW8+xVg6KcMq2OMOtI0rmdg8raRJH6LIxCIh2tg20/HBSzsBnFO7jLNSVD932
         bxKkp+EoCEm2KAdQWfkzce0TEHurezQgU0QFjndyCvr+NsRRUo1JZ40IfCAZmQ+Qnpk4
         9v+TnIDQCfZ+6ixxISAcmI3HyawY+7jiRSru4jg0LW6z3Su/t2fmuakDFO9N3tv6Sjt7
         XE6nwqeWYy2avtTYErOTbKpcdA82ksZxOLa00bX+I7b0fVDiaFcAcAC93jxqXjV6I9Kx
         3HDg==
X-Gm-Message-State: APjAAAX+ogbu5/un4W3rIsRxeXNHSuK9AscdSS5heOFcRSatog7wyfeO
        q+07Hil0LKsNtcILxL4YaEs=
X-Google-Smtp-Source: APXvYqyj6JRGuyKFVe5vaGWRh4o1Xm/1hckUsY1CBqdwbP6Ef7LPKpdfFvd9VQyx97Z6/0qfItIGLw==
X-Received: by 2002:a1c:1aca:: with SMTP id a193mr4633488wma.120.1570053848892;
        Wed, 02 Oct 2019 15:04:08 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id r13sm813895wrn.0.2019.10.02.15.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 15:04:08 -0700 (PDT)
Date:   Thu, 3 Oct 2019 00:04:06 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] membarrier fix
Message-ID: <20191002220406.GA50484@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest sched-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

   # HEAD: 73956fc07dd7b25d4a33ab3fdd6247c60d0b237c membarrier: Fix RCU locking bug caused by faulty merge

Fix a merge bug that resulted in broken locking within 
membarrier_private_expedited().

 Thanks,

	Ingo

------------------>
Peter Zijlstra (1):
      membarrier: Fix RCU locking bug caused by faulty merge


 kernel/sched/membarrier.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index a39bed2c784f..168479a7d61b 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -174,7 +174,6 @@ static int membarrier_private_expedited(int flags)
 		 */
 		if (cpu == raw_smp_processor_id())
 			continue;
-		rcu_read_lock();
 		p = rcu_dereference(cpu_rq(cpu)->curr);
 		if (p && p->mm == mm)
 			__cpumask_set_cpu(cpu, tmpmask);
